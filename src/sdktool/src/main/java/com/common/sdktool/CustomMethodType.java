package com.common.sdktool;

public enum CustomMethodType {
    ShowCenter(0), ShowBBS(1);

    int value;

    private CustomMethodType(int value) {
        this.value = value;
    }

    public static CustomMethodType valueOf(int value) { // 手写的从int到enum的转换函数
        switch (value) {
            case 0:
                return ShowCenter;
            case 1:
                return ShowBBS;
        }
        return null;
    }

    public int value() {
        return this.value;
    }
}
