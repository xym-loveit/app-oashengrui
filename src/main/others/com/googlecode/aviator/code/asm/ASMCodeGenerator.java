/**
 *  Copyright (C) 2010 dennis zhuang (killme2008@gmail.com)
 *
 *  This library is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published
 *  by the Free Software Foundation; either version 2.1 of the License, or
 *  (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 **/
package com.googlecode.aviator.code.asm;

import static com.googlecode.aviator.asm.Opcodes.*;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import java.util.concurrent.atomic.AtomicLong;

import com.googlecode.aviator.AviatorEvaluator;
import com.googlecode.aviator.Expression;
import com.googlecode.aviator.asm.ClassVisitor;
import com.googlecode.aviator.asm.ClassWriter;
import com.googlecode.aviator.asm.Label;
import com.googlecode.aviator.asm.MethodVisitor;
import com.googlecode.aviator.asm.util.CheckClassAdapter;
import com.googlecode.aviator.asm.util.TraceClassVisitor;
import com.googlecode.aviator.code.CodeGenerator;
import com.googlecode.aviator.exception.CompileExpressionErrorException;
import com.googlecode.aviator.lexer.token.NumberToken;
import com.googlecode.aviator.lexer.token.Token;
import com.googlecode.aviator.lexer.token.Variable;
import com.googlecode.aviator.parser.AviatorClassLoader;


/**
 * Code generator using asm
 * 
 * @author dennis
 * 
 */
public class ASMCodeGenerator implements CodeGenerator {
    private static final String FIELD_PREFIX = "var_";
    // Class Writer to generate class
    private final ClassWriter classWriter;
    // Trace visitor
    private ClassVisitor traceClassVisitor;
    // Check visitor
    private ClassVisitor checkClassAdapter;
    // Method visitor
    private MethodVisitor mv;
    // Class name
    private final String className;
    // Class loader to define generated class
    private final AviatorClassLoader classLoader;

    private static final AtomicLong CLASS_COUNTER = new AtomicLong();

    /**
     * Operands count to check stack frames
     */
    private int operandsCount = 0;

    private int maxStacks = 0;
    private int maxLocals = 2;

    private int fieldCounter = 0;

    private Map<String/* variable name */, String/* inner var name */> innerVarMap = new HashMap<String, String>();

    private Map<String/* method name */, String/* inner method name */> innerMethodMap = new HashMap<String, String>();

    private Map<String, Integer/* counter */> varTokens = new LinkedHashMap<String, Integer>();
    private Map<String, Integer/* counter */> methodTokens = new HashMap<String, Integer>();

    private Map<Label, Map<String/* inner name */, Integer/* local index */>> labelNameIndexMap =
            new HashMap<Label, Map<String, Integer>>();

    private static final Label START_LABEL = new Label();

    private Label currentLabel = START_LABEL;


    private void setMaxStacks(int newMaxStacks) {
        if (newMaxStacks > this.maxStacks) {
            this.maxStacks = newMaxStacks;
        }
    }


    public ASMCodeGenerator(AviatorClassLoader classLoader, OutputStream traceOut, boolean trace) {
        this.classLoader = classLoader;
        // Generate inner class name
        this.className = "Script_" + System.currentTimeMillis() + "_" + CLASS_COUNTER.getAndIncrement();
        // Auto compute frames
        this.classWriter = new ClassWriter(ClassWriter.COMPUTE_FRAMES);
        if (trace) {
            this.traceClassVisitor = new TraceClassVisitor(this.classWriter, new PrintWriter(traceOut));
            this.checkClassAdapter = new CheckClassAdapter(this.traceClassVisitor);
        }
        else {
            this.checkClassAdapter = new CheckClassAdapter(this.classWriter);
        }
        visitClass();
    }


    public void start() {
        this.makeConstructor();
        this.startVisitMethodCode();
    }


    private void startVisitMethodCode() {
        this.mv =
                checkClassAdapter.visitMethod(ACC_PUBLIC + +ACC_FINAL, "execute0",
                    "(Ljava/util/Map;)Ljava/lang/Object;",
                    "(Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;)Ljava/lang/Object;", null);
        this.mv.visitCode();
    }


    private void endVisitMethodCode() {
        if (this.operandsCount > 0) {
            this.loadEnv();
            this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "getValue",
                "(Ljava/util/Map;)Ljava/lang/Object;");
            this.mv.visitInsn(ARETURN);
            this.popOperand();
            this.popOperand();
        }
        else {
            this.mv.visitInsn(ACONST_NULL);
            this.mv.visitInsn(ARETURN);
            this.pushOperand(0);
            this.popOperand();
        }
        if (this.operandsCount > 0) {
            throw new CompileExpressionErrorException("operand stack is not empty,count=" + this.operandsCount);
        }
        this.mv.visitMaxs(this.maxStacks, this.maxLocals);
        this.mv.visitEnd();

    }


    private void endVisitClass() {
        this.checkClassAdapter.visitEnd();
    }


    /**
     * Make a default constructor
     */
    private void makeConstructor() {
        {
            this.mv = this.checkClassAdapter.visitMethod(ACC_PUBLIC, "<init>", "(Ljava/util/List;)V", null, null);
            this.mv.visitCode();
            this.mv.visitVarInsn(ALOAD, 0);
            this.mv.visitVarInsn(ALOAD, 1);
            mv.visitMethodInsn(INVOKESPECIAL, "com/googlecode/aviator/ClassExpression", "<init>", "(Ljava/util/List;)V");
            if (!this.innerVarMap.isEmpty()) {
                for (Map.Entry<String, String> entry : this.innerVarMap.entrySet()) {
                    String outterName = entry.getKey();
                    String innerName = entry.getValue();
                    this.mv.visitVarInsn(ALOAD, 0);
                    this.mv.visitTypeInsn(NEW, "com/googlecode/aviator/runtime/type/AviatorJavaType");
                    this.mv.visitInsn(DUP);
                    this.mv.visitLdcInsn(outterName);
                    this.mv.visitMethodInsn(INVOKESPECIAL, "com/googlecode/aviator/runtime/type/AviatorJavaType",
                        "<init>", "(Ljava/lang/String;)V");
                    this.mv.visitFieldInsn(PUTFIELD, this.className, innerName,
                        "Lcom/googlecode/aviator/runtime/type/AviatorJavaType;");
                }
            }
            if (!this.innerMethodMap.isEmpty()) {
                for (Map.Entry<String, String> entry : this.innerMethodMap.entrySet()) {
                    String outterName = entry.getKey();
                    String innerName = entry.getValue();
                    this.mv.visitVarInsn(ALOAD, 0);
                    this.mv.visitLdcInsn(outterName);
                    this.mv.visitMethodInsn(INVOKESTATIC, "com/googlecode/aviator/AviatorEvaluator", "getFunction",
                        "(Ljava/lang/String;)Lcom/googlecode/aviator/runtime/type/AviatorFunction;");
                    this.mv.visitFieldInsn(PUTFIELD, this.className, innerName,
                        "Lcom/googlecode/aviator/runtime/type/AviatorFunction;");
                }
            }

            this.mv.visitInsn(RETURN);
            this.mv.visitMaxs(4, 1);
            this.mv.visitEnd();
        }
    }


    private void visitClass() {
        this.checkClassAdapter.visit(AviatorEvaluator.BYTECODE_VER, ACC_PUBLIC + ACC_SUPER, this.className, null,
            "com/googlecode/aviator/ClassExpression", null);
    }


    /**
     * Make a label
     * 
     * @return
     */
    private Label makeLabel() {
        return new Label();
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onAdd(com.googlecode.aviator
     * .lexer.token.Token)
     */
    public void onAdd(Token<?> lookhead) {
        this.doArthOperation("add");
    }


    /**
     * Do arithmetic operation
     * 
     * @param methodName
     */
    private void doArthOperation(String methodName) {
        this.loadEnv();
        this.mv
            .visitMethodInsn(
                INVOKEVIRTUAL,
                "com/googlecode/aviator/runtime/type/AviatorObject",
                methodName,
                "(Lcom/googlecode/aviator/runtime/type/AviatorObject;Ljava/util/Map;)Lcom/googlecode/aviator/runtime/type/AviatorObject;");
        this.popOperand();
        this.popOperand();
    }


    /**
     * Pop a operand from stack
     */
    private void popOperand() {
        this.operandsCount--;
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onSub(com.googlecode.aviator
     * .lexer.token.Token)
     */
    public void onSub(Token<?> lookhead) {
        this.doArthOperation("sub");
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onMult(com.googlecode.aviator
     * .lexer.token.Token)
     */
    public void onMult(Token<?> lookhead) {
        this.doArthOperation("mult");
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onDiv(com.googlecode.aviator
     * .lexer.token.Token)
     */
    public void onDiv(Token<?> lookhead) {
        this.doArthOperation("div");
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onMod(com.googlecode.aviator
     * .lexer.token.Token)
     */
    public void onMod(Token<?> lookhead) {
        this.doArthOperation("mod");
    }


    /**
     * Do logic operation "&&" left operand
     */
    public void onAndLeft(Token<?> lookhead) {
        this.loadEnv();
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "booleanValue",
            "(Ljava/util/Map;)Z");
        Label l0 = makeLabel();
        pushLabel0(l0);
        this.mv.visitJumpInsn(IFEQ, l0);

        this.popOperand(); // boolean object
        this.popOperand(); // environment

    }


    private void pushLabel0(Label l0) {
        this.l0stack.push(l0);
    }


    /**
     * Do logic operation "&&" right operand
     */
    public void onAndRight(Token<?> lookhead) {
        this.loadEnv();
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "booleanValue",
            "(Ljava/util/Map;)Z");
        this.mv.visitJumpInsn(IFEQ, peekLabel0());
        // Result is true
        this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "TRUE",
            "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
        Label l1 = makeLabel();
        this.mv.visitJumpInsn(GOTO, l1);
        visitLabel(popLabel0());
        // Result is false
        this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "FALSE",
            "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
        visitLabel(l1);

        this.popOperand(); // boolean object
        this.popOperand(); // environment
        this.pushOperand(0);
    }

    /**
     * Label stack for ternary operator
     */
    private final Stack<Label> l0stack = new Stack<Label>();
    private final Stack<Label> l1stack = new Stack<Label>();


    public void onTernaryBoolean(Token<?> lookhead) {
        this.loadEnv();
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "booleanValue",
            "(Ljava/util/Map;)Z");
        Label l0 = makeLabel();
        Label l1 = makeLabel();
        pushLabel0(l0);
        pushLabel1(l1);
        this.mv.visitJumpInsn(IFEQ, l0);
        this.popOperand();
        this.popOperand();
        this.pushOperand(1); // add two booleans

        this.popOperand(); // pop the last result
    }


    private void pushLabel1(Label l1) {
        this.l1stack.push(l1);
    }


    public void onTernaryLeft(Token<?> lookhead) {
        this.mv.visitJumpInsn(GOTO, peekLabel1());
        visitLabel(popLabel0());
        this.popOperand(); // pop one boolean
    }


    private Label peekLabel1() {
        return this.l1stack.peek();
    }


    public void onTernaryRight(Token<?> lookhead) {
        visitLabel(popLabel1());
        this.popOperand(); // pop one boolean
    }


    private Label popLabel1() {
        return this.l1stack.pop();
    }


    /**
     * Do logic operation "||" right operand
     */
    public void onJoinRight(Token<?> lookhead) {
        this.loadEnv();
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "booleanValue",
            "(Ljava/util/Map;)Z");
        Label l1 = makeLabel();
        this.mv.visitJumpInsn(IFNE, peekLabel0());
        // Result is False
        this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "FALSE",
            "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
        this.mv.visitJumpInsn(GOTO, l1);
        visitLabel(popLabel0());
        // Result is True
        this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "TRUE",
            "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
        visitLabel(l1);
        this.popOperand();
        this.popOperand();
        this.pushOperand(0);

    }


    private void visitLabel(Label label) {
        this.mv.visitLabel(label);
        this.currentLabel = label;
    }


    private Label peekLabel0() {
        return this.l0stack.peek();
    }


    private Label popLabel0() {
        return this.l0stack.pop();
    }


    /**
     * Do logic operation "||" left operand
     */
    public void onJoinLeft(Token<?> lookhead) {
        this.loadEnv();
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "booleanValue",
            "(Ljava/util/Map;)Z");
        Label l0 = makeLabel();
        pushLabel0(l0);
        this.mv.visitJumpInsn(IFNE, l0);

        this.popOperand();
        this.popOperand();

    }


    public void onEq(Token<?> lookhead) {
        this.doCompareAndJump(IFNE);
    }


    public void onMatch(Token<?> lookhead) {
        this.mv.visitInsn(SWAP);
        this.loadEnv();
        this.mv
            .visitMethodInsn(
                INVOKEVIRTUAL,
                "com/googlecode/aviator/runtime/type/AviatorObject",
                "match",
                "(Lcom/googlecode/aviator/runtime/type/AviatorObject;Ljava/util/Map;)Lcom/googlecode/aviator/runtime/type/AviatorObject;");

        this.popOperand();
        this.popOperand();
        this.popOperand();
        this.pushOperand(0);
    }


    public void onNeq(Token<?> lookhead) {
        this.doCompareAndJump(IFEQ);
    }


    private void doCompareAndJump(int ints) {
        this.loadEnv();
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "compare",
            "(Lcom/googlecode/aviator/runtime/type/AviatorObject;Ljava/util/Map;)I");
        Label l0 = this.makeLabel();
        Label l1 = this.makeLabel();
        this.mv.visitJumpInsn(ints, l0);
        this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "TRUE",
            "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
        this.mv.visitJumpInsn(GOTO, l1);
        visitLabel(l0);
        this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "FALSE",
            "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
        visitLabel(l1);
        this.popOperand();
        this.popOperand();
        this.popOperand();
        this.pushOperand(0);
    }


    public void onGe(Token<?> lookhead) {
        this.doCompareAndJump(IFLT);
    }


    public void onGt(Token<?> lookhead) {
        this.doCompareAndJump(IFLE);
    }


    public void onLe(Token<?> lookhead) {
        this.doCompareAndJump(IFGT);

    }


    public void onLt(Token<?> lookhead) {
        this.doCompareAndJump(IFGE);
    }


    /**
     * 
     * @param extras
     *            额外的栈空间大小
     */
    public void pushOperand(int extras) {
        this.operandsCount++;
        this.operandsCount += extras;
        this.setMaxStacks(this.operandsCount);
    }


    /**
     * Logic operation '!'
     */
    public void onNot(Token<?> lookhead) {
        this.pushOperand(0);

        this.mv.visitTypeInsn(CHECKCAST, "com/googlecode/aviator/runtime/type/AviatorObject");
        this.mv.visitVarInsn(ALOAD, 1);
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "not",
            "(Ljava/util/Map;)Lcom/googlecode/aviator/runtime/type/AviatorObject;");

        this.popOperand();
        this.popOperand();
        this.pushOperand(0);
    }


    /**
     * Bit operation '~'
     */
    public void onBitNot(Token<?> lookhead) {
        this.pushOperand(0);
        this.mv.visitTypeInsn(CHECKCAST, "com/googlecode/aviator/runtime/type/AviatorObject");
        this.mv.visitVarInsn(ALOAD, 1);
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "bitNot",
            "(Ljava/util/Map;)Lcom/googlecode/aviator/runtime/type/AviatorObject;");
        this.popOperand();
        this.popOperand();
        this.pushOperand(0);
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onNeg(com.googlecode.aviator
     * .lexer.token.Token, int)
     */
    public void onNeg(Token<?> lookhead) {
        this.pushOperand(0);

        this.mv.visitTypeInsn(CHECKCAST, "com/googlecode/aviator/runtime/type/AviatorObject");
        this.mv.visitVarInsn(ALOAD, 1);
        this.mv.visitMethodInsn(INVOKEVIRTUAL, "com/googlecode/aviator/runtime/type/AviatorObject", "neg",
            "(Ljava/util/Map;)Lcom/googlecode/aviator/runtime/type/AviatorObject;");
        this.popOperand();
        this.popOperand();
        this.pushOperand(0);
    }


    /*
     * (non-Javadoc)
     * 
     * @see com.googlecode.aviator.code.CodeGenerator#getResult()
     */
    public Expression getResult() {
        end();

        byte[] bytes = this.classWriter.toByteArray();
        try {
            Class<?> defineClass = this.classLoader.defineClass(this.className, bytes);
            Constructor<?> constructor = defineClass.getConstructor(List.class);
            return (Expression) constructor.newInstance(new ArrayList<String>(this.varTokens.keySet()));
        }
        catch (Exception e) {
            throw new CompileExpressionErrorException("define class error", e);
        }
    }


    private void end() {
        this.endVisitMethodCode();
        this.endVisitClass();
    }


    /*
     * (non-Javadoc)
     * 
     * @see
     * com.googlecode.aviator.code.CodeGenerator#onConstant(com.googlecode.aviator
     * .lexer.token.Token)
     */
    public void onConstant(Token<?> lookhead) {
        if (lookhead == null) {
            return;
        }
        // load token to stack
        switch (lookhead.getType()) {
        case Number:
            // load numbers
            NumberToken numberToken = (NumberToken) lookhead;
            if (numberToken.getNumber() instanceof Double) {
                this.mv.visitLdcInsn(numberToken.getNumber());
                this.mv.visitMethodInsn(INVOKESTATIC, "com/googlecode/aviator/runtime/type/AviatorDouble", "valueOf",
                    "(D)Lcom/googlecode/aviator/runtime/type/AviatorDouble;");
            }
            else {
                this.mv.visitLdcInsn(numberToken.getNumber());
                this.mv.visitMethodInsn(INVOKESTATIC, "com/googlecode/aviator/runtime/type/AviatorLong", "valueOf",
                    "(J)Lcom/googlecode/aviator/runtime/type/AviatorLong;");
            }
            this.pushOperand(0);
            // this.popOperand();
            // this.popOperand();
            break;
        case String:
            // load string
            this.mv.visitTypeInsn(NEW, "com/googlecode/aviator/runtime/type/AviatorString");
            this.mv.visitInsn(DUP);
            this.mv.visitLdcInsn(lookhead.getValue(null));
            this.mv.visitMethodInsn(INVOKESPECIAL, "com/googlecode/aviator/runtime/type/AviatorString", "<init>",
                "(Ljava/lang/String;)V");
            this.pushOperand(2);
            this.popOperand();
            this.popOperand();
            break;
        case Pattern:
            // load pattern
            this.mv.visitTypeInsn(NEW, "com/googlecode/aviator/runtime/type/AviatorPattern");
            this.mv.visitInsn(DUP);
            this.mv.visitLdcInsn(lookhead.getValue(null));
            this.mv.visitMethodInsn(INVOKESPECIAL, "com/googlecode/aviator/runtime/type/AviatorPattern", "<init>",
                "(Ljava/lang/String;)V");
            this.pushOperand(2);
            this.popOperand();
            this.popOperand();
            break;
        case Variable:
            // load variable
            Variable variable = (Variable) lookhead;

            if (variable.equals(Variable.TRUE)) {
                this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "TRUE",
                    "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
                this.pushOperand(0);
            }
            else if (variable.equals(Variable.FALSE)) {
                this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorBoolean", "FALSE",
                    "Lcom/googlecode/aviator/runtime/type/AviatorBoolean;");
                this.pushOperand(0);
            }
            else if (variable.equals(Variable.NIL)) {
                this.mv.visitFieldInsn(GETSTATIC, "com/googlecode/aviator/runtime/type/AviatorNil", "NIL",
                    "Lcom/googlecode/aviator/runtime/type/AviatorNil;");
                this.pushOperand(0);
            }
            else {
                String outterVarName = variable.getLexeme();
                String innerVarName = this.innerVarMap.get(outterVarName);
                if (innerVarName != null) {
                    // Is it stored in local?
                    Map<String, Integer> name2Index = labelNameIndexMap.get(currentLabel);
                    if (name2Index != null && name2Index.get(innerVarName) != null) {
                        int localIndex = name2Index.get(innerVarName);
                        this.mv.visitVarInsn(ALOAD, localIndex);
                        this.pushOperand(0);
                    }
                    else {
                        // Get field at first time
                        this.mv.visitVarInsn(ALOAD, 0);
                        this.mv.visitFieldInsn(GETFIELD, this.className, innerVarName,
                            "Lcom/googlecode/aviator/runtime/type/AviatorJavaType;");
                        // Variable is used more than once,store it to local
                        if (this.varTokens.get(outterVarName) > 1) {
                            this.mv.visitInsn(DUP);
                            int localIndex = getLocalIndex();
                            this.mv.visitVarInsn(ASTORE, localIndex);
                            if (name2Index == null) {
                                name2Index = new HashMap<String, Integer>();
                                this.labelNameIndexMap.put(currentLabel, name2Index);
                            }
                            name2Index.put(innerVarName, localIndex);
                            this.pushOperand(2);
                            this.popOperand();
                            this.popOperand();
                        }
                        else {
                            this.pushOperand(1);
                            this.popOperand();
                        }
                    }

                }
                else {
                    this.mv.visitTypeInsn(NEW, "com/googlecode/aviator/runtime/type/AviatorJavaType");
                    this.mv.visitInsn(DUP);
                    this.mv.visitLdcInsn(outterVarName);
                    this.mv.visitMethodInsn(INVOKESPECIAL, "com/googlecode/aviator/runtime/type/AviatorJavaType",
                        "<init>", "(Ljava/lang/String;)V");
                    this.pushOperand(2);
                    this.popOperand();
                    this.popOperand();
                }

            }
            break;
        }

    }


    public void initVariables(Map<String, Integer/* counter */> varTokens) {
        this.varTokens = varTokens;
        for (String outterVarName : varTokens.keySet()) {
            // Use inner variable name instead of outter variable name
            String innerVarName = getInnerName(outterVarName);
            this.innerVarMap.put(outterVarName, innerVarName);
            this.checkClassAdapter.visitField(ACC_PRIVATE + ACC_FINAL, innerVarName,
                "Lcom/googlecode/aviator/runtime/type/AviatorJavaType;", null, null).visitEnd();

        }
    }


    public void initMethods(Map<String, Integer/* counter */> methods) {
        this.methodTokens = methods;
        for (String outterMethodName : methods.keySet()) {
            // Use inner method name instead of outter method name
            String innerMethodName = getInnerName(outterMethodName);
            this.innerMethodMap.put(outterMethodName, innerMethodName);
            this.checkClassAdapter.visitField(ACC_PRIVATE + ACC_FINAL, innerMethodName,
                "Lcom/googlecode/aviator/runtime/type/AviatorFunction;", null, null).visitEnd();

        }
    }


    private String getInnerName(String varName) {
        return FIELD_PREFIX + (this.fieldCounter++);
    }


    private String getInvokeMethodDesc(int paramCount) {
        StringBuilder sb = new StringBuilder("(Ljava/util/Map;");
        for (int i = 0; i < paramCount; i++) {
            sb.append("Lcom/googlecode/aviator/runtime/type/AviatorObject;");
        }
        sb.append(")Lcom/googlecode/aviator/runtime/type/AviatorObject;");
        return sb.toString();
    }


    public void onMethodInvoke(Token<?> lookhead) {
        final MethodMetaData methodMetaData = this.methodMetaDataStack.pop();
        final int parameterCount = methodMetaData.parameterCount;
        this.mv.visitMethodInsn(INVOKEINTERFACE, "com/googlecode/aviator/runtime/type/AviatorFunction", "call",
            this.getInvokeMethodDesc(parameterCount));

        this.popOperand(); // method object
        this.popOperand(); // env map
        // pop operands
        for (int i = 0; i < parameterCount; i++) {
            this.popOperand();
        }
        // push result
        this.pushOperand(0);
    }


    public void onMethodParameter(Token<?> lookhead) {
        this.methodMetaDataStack.peek().parameterCount++;
        // // add parameter to list
        // this.mv.visitMethodInsn(INVOKEINTERFACE, "java/util/List", "add",
        // "(Ljava/lang/Object;)Z");
        // // pop boolean
        // this.mv.visitInsn(POP);
        // this.mv.visitVarInsn(ALOAD,
        // this.methodMetaDataStack.peek().parameterListIndex);
    }

    private static class MethodMetaData {
        @SuppressWarnings("unused")
		final String methodName;

        int parameterCount;


        public MethodMetaData(String methodName) {
            super();
            this.methodName = methodName;
            this.parameterCount = 0;
        }

    }

    private final Stack<MethodMetaData> methodMetaDataStack = new Stack<MethodMetaData>();


    public void onArray(Token<?> lookhead) {
        this.onConstant(lookhead);
    }


    public void onArrayIndexStart(Token<?> token) {
        this.loadEnv();
    }


    public void onArrayIndexEnd(Token<?> lookhead) {
        this.mv
            .visitMethodInsn(
                INVOKEVIRTUAL,
                "com/googlecode/aviator/runtime/type/AviatorObject",
                "getElement",
                "(Ljava/util/Map;Lcom/googlecode/aviator/runtime/type/AviatorObject;)Lcom/googlecode/aviator/runtime/type/AviatorObject;");

        this.popOperand();
        this.popOperand();
        this.popOperand();
        this.pushOperand(0);
    }


    public int getLocalIndex() {
        return this.maxLocals++;
    }


    public void onMethodName(Token<?> lookhead) {
        String outtterMethodName = lookhead.getLexeme();
        String innerMethodName = this.innerMethodMap.get(outtterMethodName);
        if (innerMethodName != null) {
            loadAviatorFunction(outtterMethodName, innerMethodName);
        }
        else {
            this.createAviatorFunctionObject(outtterMethodName);
        }
        this.loadEnv();
        this.methodMetaDataStack.push(new MethodMetaData(outtterMethodName));
    }


    private void loadAviatorFunction(String outterMethodName, String innerMethodName) {
        Map<String, Integer> name2Index = this.labelNameIndexMap.get(currentLabel);
        // Is it stored in local?
        if (name2Index != null && name2Index.containsKey(innerMethodName)) {
            int localIndex = name2Index.get(innerMethodName);
            this.mv.visitVarInsn(ALOAD, localIndex);
            this.pushOperand(0);
        }
        else {
            this.mv.visitVarInsn(ALOAD, 0);
            this.mv.visitFieldInsn(GETFIELD, this.className, innerMethodName,
                "Lcom/googlecode/aviator/runtime/type/AviatorFunction;");
            // Method is used more than once,store it to local for reusing
            if (this.methodTokens.get(outterMethodName) > 1) {
                this.mv.visitInsn(DUP);
                int localIndex = getLocalIndex();
                this.mv.visitVarInsn(ASTORE, localIndex);
                if (name2Index == null) {
                    name2Index = new HashMap<String, Integer>();
                    this.labelNameIndexMap.put(currentLabel, name2Index);
                }
                name2Index.put(innerMethodName, localIndex);
                this.pushOperand(1);
                this.popOperand();
            }
            else {
                this.pushOperand(0);
            }
        }
    }


    // private int createArugmentList() {
    // // create argument list
    // this.pushOperand(0);
    // this.pushOperand(0);
    // this.mv.visitTypeInsn(NEW, "java/util/ArrayList");
    // this.mv.visitInsn(DUP);
    // this.popOperand();
    // this.mv.visitMethodInsn(INVOKESPECIAL, "java/util/ArrayList", "<init>",
    // "()V");
    // // store to local variable
    // final int parameterLocalIndex = this.getLocalIndex();
    // this.mv.visitVarInsn(ASTORE, parameterLocalIndex);
    // this.mv.visitVarInsn(ALOAD, parameterLocalIndex);
    // return parameterLocalIndex;
    // }

    private void loadEnv() {
        // load env
        this.pushOperand(0);
        this.mv.visitVarInsn(ALOAD, 1);
    }


    private void createAviatorFunctionObject(String methodName) {
        this.pushOperand(0);
        this.mv.visitLdcInsn(methodName);
        this.mv.visitMethodInsn(INVOKESTATIC, "com/googlecode/aviator/AviatorEvaluator", "getFunction",
            "(Ljava/lang/String;)Lcom/googlecode/aviator/runtime/type/AviatorFunction;");
        this.popOperand();
        this.pushOperand(0);
    }


    public void onBitAnd(Token<?> lookhead) {
        this.doArthOperation("bitAnd");
    }


    public void onBitOr(Token<?> lookhead) {
        this.doArthOperation("bitOr");
    }


    public void onBitXor(Token<?> lookhead) {
        this.doArthOperation("bitXor");
    }


    public void onShiftLeft(Token<?> lookhead) {
        this.doArthOperation("shiftLeft");

    }


    public void onShiftRight(Token<?> lookhead) {
        this.doArthOperation("shiftRight");

    }


    public void onUnsignedShiftRight(Token<?> lookhead) {
        this.doArthOperation("unsignedShiftRight");

    }

}
