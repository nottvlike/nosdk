package com.common.sdktool;

public enum ExtraDataType {
	CreatePlayer(0), EnterGame(1), LevelUp(2), ExitGame(3);

	int value;

	private ExtraDataType(int value) {
		this.value = value;
	}

	public static ExtraDataType valueOf(int value) { // 手写的从int到enum的转换函数
		switch (value) {
		case 0:
			return CreatePlayer;
		case 1:
			return EnterGame;
		case 2:
			return LevelUp;
		case 3:
			return ExitGame;
		}
		return null;
	}

	public int value() {
		return this.value;
	}
}
