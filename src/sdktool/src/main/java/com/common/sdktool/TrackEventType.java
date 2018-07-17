package com.common.sdktool;

public enum TrackEventType {
    CreatePlayer(0), EnterGame(1), LevelUp(2), VipLevelUp(3), ExitGame(4);

    int value;

    private TrackEventType(int value) {
        this.value = value;
    }

    public static TrackEventType valueOf(int value) { // 手写的从int到enum的转换函数
        switch (value) {
            case 0:
                return CreatePlayer;
            case 1:
                return EnterGame;
            case 2:
                return LevelUp;
            case 3:
                return VipLevelUp;
            case 4:
                return ExitGame;
        }
        return null;
    }

    public int value() {
        return this.value;
    }
}
