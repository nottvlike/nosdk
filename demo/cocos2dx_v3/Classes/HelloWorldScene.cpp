/****************************************************************************
 Copyright (c) 2017-2018 Xiamen Yaji Software Co., Ltd.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#include "HelloWorldScene.h"
#include "AppMacros.h"
#include "ui/CocosGUI.h"
#include "SDKManager.h"

USING_NS_CC;


Scene* HelloWorld::scene()
{
     return HelloWorld::create();
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !Scene::init() )
    {
        return false;
    }
    
    auto visibleSize = Director::getInstance()->getVisibleSize();
    auto origin = Director::getInstance()->getVisibleOrigin();

    auto initBtn = ui::Button::create(); 
    initBtn->setTitleText("init");
 
    initBtn->addTouchEventListener([&](Ref* sender, ui::Widget::TouchEventType type){
        switch (type)
        {
        case ui::Widget::TouchEventType::BEGAN:
                break;
        case ui::Widget::TouchEventType::ENDED:
                SDKManager::sharedInstance()->Init("");
                break;
        default:
                break;
        }
    });

    initBtn->setContentSize(Size(100, 40));
    initBtn->setPosition(Vec2(visibleSize.width / 2 - 50, visibleSize.height * 5 / 5));
    this->addChild(initBtn, 1);

    auto loginBtn = ui::Button::create(); 
    loginBtn->setTitleText("login");
 
    loginBtn->addTouchEventListener([&](Ref* sender, ui::Widget::TouchEventType type){
        switch (type)
        {
        case ui::Widget::TouchEventType::BEGAN:
                break;
        case ui::Widget::TouchEventType::ENDED:
                SDKManager::sharedInstance()->Login("");
                break;
        default:
                break;
        }
    });

    loginBtn->setContentSize(Size(100, 40));
    loginBtn->setPosition(Vec2(visibleSize.width / 2 - 50, visibleSize.height * 4 / 5));
    this->addChild(loginBtn, 1);

    auto logoutBtn = ui::Button::create(); 
    logoutBtn->setTitleText("logout");
 
    logoutBtn->addTouchEventListener([&](Ref* sender, ui::Widget::TouchEventType type){
        switch (type)
        {
        case ui::Widget::TouchEventType::BEGAN:
                break;
        case ui::Widget::TouchEventType::ENDED:
                SDKManager::sharedInstance()->Logout("");
                break;
        default:
                break;
        }
    });

    logoutBtn->setContentSize(Size(100, 40));
    logoutBtn->setPosition(Vec2(visibleSize.width / 2 - 50, visibleSize.height * 3 / 5));
    this->addChild(logoutBtn, 1);

    auto payBtn = ui::Button::create(); 
    payBtn->setTitleText("pay");
 
    payBtn->addTouchEventListener([&](Ref* sender, ui::Widget::TouchEventType type){
        switch (type)
        {
        case ui::Widget::TouchEventType::BEGAN:
                break;
        case ui::Widget::TouchEventType::ENDED:
                SDKManager::sharedInstance()->Pay(6, "RNY", "1111", "6元宝", "6元宝", "2222222222", "", "");
                break;
        default:
                break;
        }
    });

    payBtn->setContentSize(Size(100, 40));
    payBtn->setPosition(Vec2(visibleSize.width / 2 - 50, visibleSize.height * 2 / 5));
    this->addChild(payBtn, 1);

    auto exitBtn = ui::Button::create(); 
    exitBtn->setTitleText("exit");
 
    exitBtn->addTouchEventListener([&](Ref* sender, ui::Widget::TouchEventType type){
        switch (type)
        {
        case ui::Widget::TouchEventType::BEGAN:
                break;
        case ui::Widget::TouchEventType::ENDED:
                SDKManager::sharedInstance()->Exit();
                break;
        default:
                break;
        }
    });

    exitBtn->setContentSize(Size(100, 40));
    exitBtn->setPosition(Vec2(visibleSize.width / 2 - 50, visibleSize.height * 1 / 5));
    this->addChild(exitBtn, 1);

    auto drawNode = DrawNode::create();
    drawNode->setPosition(Vec2(0, 0));
    addChild(drawNode);

    Rect safeArea = Director::getInstance()->getSafeAreaRect();
    drawNode->drawRect(safeArea.origin, safeArea.origin + safeArea.size, Color4F::BLUE);

    return true;
}

void HelloWorld::menuCloseCallback(Ref* sender)
{
    Director::getInstance()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
