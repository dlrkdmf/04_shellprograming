1.    프로그램 작성과 실행
    
    #bash -x script.sh
    
    #. ~/.bashrc
    
    #vi [script.sh](http://script.sh) ; chmod +x script.sh ; ./script.sh
    
    #vi [script.sh](http://script.sh) ; chmod +x script.sh ; ./script.sh
    
    [참고] 매직넘버(#!/bin/bash)
    
    2.주석처리
    
    - 한줄 주석            #
    - 여러줄 주석          : << EOF ~ EOF
    
    3.입력 & 출력
    
    출력 : echo CMD , printf CMD
    
    입력 : read CMD
    
    1. 산술연산
    
    expr 1 + 2 
    
    expr 3 - 1
    
    expr 3 \* 3      곱하기
    
    expr 10 / 2
    
    expr 10 % 3     나머지
    
    1. 조건문:if문, case문
    
    if구문
    
    if 조건; then
    
    statement1
    
    elif 조건; then
    
    statement2
    
    else 
    
    statement3
    
    fi
    

  case 문

case VAR in

조건1) statement1 ;;

조건2) statement2 ;;

*)    statement3 ;;
