*** Settings ***
Library    SeleniumLibrary
Resource   ../keywords/CommonKeywords.robot
Variables  ../resources/config/config.yaml
Variables  ../resources/testdata/testdata.yaml

Suite Setup    Open Browser    ${baseUrl}    chrome

*** Test Cases ***
Register a new account on Future Skill
    Step 1: Navigate to Future Skill website
    Step 2: Click "สมัครสมาชิก" button
    Step 3: Fill out registration form
    Step 4: Submit registration form
    Step 5: Verify OTP page message

*** Keywords ***

Step 1: Navigate to Future Skill website
    [Documentation]    เปิดเว็บไซต์ Future Skill
    Go To    ${baseUrl}

Step 2: Click "สมัครสมาชิก" button
    [Documentation]    คลิกปุ่ม "สมัครสมาชิก" บนหน้าแรกของ Future Skill
    CommonKeywords.Wait until element is ready then click element    xpath=//button[text()="สมัครสมาชิก"]

Step 3: Fill out registration form
    [Documentation]    กรอกข้อมูลสมัครสมาชิก เช่น อีเมล รหัสผ่าน ชื่อ นามสกุล และเบอร์โทรศัพท์
    CommonKeywords.Wait until element is ready then input text    name=email    ${email}
    
    # รอและกรอกข้อมูลในฟิลด์ต่าง ๆ
    Wait Until Element Is Visible    xpath=//input[@name='newPassword']    30s
    Input Text    xpath=//input[@name='newPassword']    ${password}

    Wait Until Element Is Visible    xpath=//input[@name='confirmPassword']    30s
    Input Text    xpath=//input[@name='confirmPassword']    ${confirmPassword}

    Wait Until Element Is Visible    xpath=//input[@name='firstName']    30s
    Input Text    xpath=//input[@name='firstName']    ${firstName}

    Wait Until Element Is Visible    xpath=//input[@name='lastName']    30s
    Input Text    xpath=//input[@name='lastName']    ${lastName}

    Wait Until Element Is Visible    xpath=//input[@name='phoneNumber']    30s
    Input Text    xpath=//input[@name='phoneNumber']    ${phoneNumber}

    Wait Until Element Is Visible    xpath=//input[@name='consent']    30s
    Click Element    xpath=//input[@name='consent']    # ติ๊กถูก checkbox

Step 4: Submit registration form
    [Documentation]    คลิกปุ่ม "สมัครสมาชิก" เพื่อส่งข้อมูล
    CommonKeywords.Wait until element is ready then click element    xpath=//button[text()="สมัครสมาชิก"]

Step 5: Verify OTP page message
    [Documentation]    ตรวจสอบข้อความว่าระบบได้ส่ง OTP ไปยังเบอร์โทรศัพท์
    Wait Until Element Is Visible    xpath=//input[@name='otpCode']    30s
    Input Text    xpath=//input[@name='otpCode']    ${otp_message}

    # ตรวจสอบข้อความ OTP
    Wait Until Page Contains    ระบบได้ส่งรหัส OTP ไปยังเบอร์โทรศัพท์
    Wait Until Element Is Visible    xpath=//button[contains(text(), 'ยืนยัน')]    30s
    Click Button    xpath=//button[contains(text(), 'ยืนยัน')]
