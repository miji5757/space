<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib tagdir="/WEB-INF/tags" prefix="chalKagTags" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>
            <style>
                /* Chrome, Safari, Edge, Opera */
                /* 경험치 바로 사용 */
                input[type='range']::-webkit-slider-thumb {
                    opacity: 0;
                }

                input[type='range'] {
                    pointer-events: none;
                }

                input[type="range"] {
                    accent-color: #F73F52;
                }

                .featured-author .featured-author-body .featured-author-quote {
                    padding: 4px !important;
                }z

                #scroll-container {
                    max-height: 200px;
                    /* 원하는 최대 높이 설정 */
                    overflow-y: auto;
                    /* 세로 스크롤 활성화 */
                    border: 1px solid #ccc;
                    /* 테두리 설정 */
                    padding: 10px;
                    /* 내부 여백 설정 */
                }


                /* ul 태그에 대한 스타일 */
                .changeList {
                    font-size: 16px;
                    list-style: none;
                    /* 리스트의 점을 없앤다 */
                    padding-left: 0;
                    /* 왼쪽 패딩을 제거해 기본적으로 생기는 들여쓰기를 없앤다 */
                    width: 100%;
                    /* 리스트의 너비를 설정한다. 필요에 따라 조정할 수 있습니다. */
                    font-family: 'Lato', sans-serif;
                    margin-top: 20px;
                }

                .changeList li {
                    /* 텍스트를 양쪽 정렬한다. */
                    margin-bottom: 15px;
                    /* 리스트 아이템 사이의 간격을 조정한다. 필요에 따라 조정할 수 있습니다. */
                }

                .changeList li:after {
                    content: '';
                    display: inline-block;
                    width: 100%;
                }

                .changeList a {
                    color: black;
                    /* 링크의 글자색을 검은색으로 변경한다. */
                    text-decoration: none;
                    /* 링크 밑줄을 제거한다. */
                    position: relative;
                    /* 밑줄을 위한 위치 지정 */
                    padding-bottom: 5px;
                    /* 밑줄과의 간격 조정 */
                }

                .changeList a:hover {
                    text-decoration: none;
                    /* 마우스 오버 시 링크의 밑줄을 제거 */
                    color: #F73F52;
                }

                .changeList a.active {
                    text-decoration: none;
                    color: #F73F52;
                    font-weight: bold;
                    /* 글자를 굵게 */
                    border-bottom: 3px solid #F73F52;
                    /* 밑줄 스타일: 두께와 색상 */
                }
            </style>

            <head>
                <chalKagTags:webCss />
            </head>

            <body>

                <chalKagTags:webHeader />

                <section class="myPage">
                    <div class="container">
                        <div class="col-xs-6 col-md-4 sidebar" id="sidebar">
                            <div class="sidebar-title for-tablet">Sidebar</div>
                            <div class="aside-body">
                                <div class="featured-author">
                                    <div class="featured-author-inner">
                                        <div class="featured-author-cover"
                                            style="background-image: url('css/user/images/news/img15.jpg');">
                                            <div class="badges">
                                                <c:if test="${memberInfo.memberGrade eq 'PREMIUM'}">
                                                    <div class="badge-item"><i class="ion-star"></i> PREMIUM</div>
                                                </c:if>
                                                <c:if test="${memberInfo.memberGrade eq 'USER'}">
                                                    <div class="badge-item"><i class="ion-star"></i> PREMIUM...할래?
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="featured-author-center">
                                                <figure class="featured-author-picture">
                                                    <img src="profileImg/${memberInfo.profileImgName}"
                                                        alt="Sample Article"
                                                        style="width: 100%; height: 100%; object-fit: cover;">
                                                </figure>
                                                <div class="featured-author-info">
                                                    <h2 class="name">${memberInfo.memberNickname}</h2>
                                                    <div class="desc">${memberInfo.memberId}</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="featured-author-body">
                                            <div class="featured-author-count">
                                                <div class="item" style="width: -webkit-calc(100% / 2);">
                                                    <a href="#">
                                                        <div class="name">Posts</div>
                                                        <div class="value">${memberInfo.postCount}</div>
                                                    </a>
                                                </div>
                                                <div class="item" style="width: -webkit-calc(100% / 2);">
                                                    <a href="#">
                                                        <div class="name">Score</div>
                                                        <c:if test="${memberInfo.currentScore != null}">
                                                            <div class="value">${memberInfo.currentScore}</div>
                                                        </c:if>
                                                        <c:if test="${memberInfo.currentScore == null}">
                                                            <div class="value">0.0</div>
                                                        </c:if>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="featured-author-quote"
                                                style="font-weight: bold; font-family: 'Lato'; font-size:19px ;">
                                                LV : ${memberInfo.currentLevel}
                                            </div>
                                            <div style="display: flex; justify-content: center;">
                                                <input type="range" id="Exp" name="Exp" min="0"
                                                    max="${memberInfo.currentNextExp}"
                                                    value="${memberInfo.currentExp}" style="width: 250px;">
                                            </div>
                                            <div class="featured-author-quote"
                                                style="font-weight: bold; font-family: 'inherit'; margin-top: 10px;">
                                                INTRODUCTION
                                            </div>
                                            <div class="featured-author-quote" id="Introdudction">
                                                <c:if test="${memberInfo.memberIntroduction != null}">
                                                    "${memberInfo.memberIntroduction}"
                                                </c:if>
                                                <c:if test="${memberInfo.memberIntroduction == null}">
                                                    " Write a self-introduction to showcase yourself "
                                                </c:if>
                                            </div>
                                            <div class="featured-author-quote">
                                                <ul class="changeList">
                                                    <li><a href="memberPage" class="active">USER INFORMATION</a></li>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </aside>
                        </div>

                        <div class="col-md-6 col-sm-12 col-xs-12">
                            <div class="box box-border">
                                <div class="box-body">
                                    <div style="display: flex; align-items: center;">
                                    <div>Basic Information <i class="ion-ios-information-outline"
                                            style="font-size: 16px; margin-bottom:15px"></i></div>
                                            <c:if test="${sessionScope.member != null}">
                                            <a href="writeReport?reportSuspector=${memberInfo.memberId}" class="btn btn-primary btn-sm" style="margin-left:61%">Report</a>
                                            </c:if>
                                            <c:if test="${sessionScope.member == null}">
                                            </c:if>

                                    </div>
                                    <div style="display: flex; align-items: center;">
                                        <figure class="featured-author-picture">
                                            <img src="profileImg/${memberInfo.profileImgName}" id="ImgPreview"
                                                alt="Image Not Loaded" style="width: 76px; 
                                    height: 76px; 
                                    border-radius: 50%; 
                                    object-fit: cover;
                                    border: 1px solid rgb(168, 168, 168);">
                                        </figure>
                                        <div style="margin-left: 10px;">
                                            <div class="memberName" id="memberName"
                                                style="font-size: 30px; font-weight: bold;">
                                                ${memberInfo.memberNickname}
                                            </div>
                                            <div class="memberId" id="memberId"
                                                style="font-size: 20px; font-weight:20px">${memberInfo.memberId}</div>
                                        </div>
                                    </div>

                                    <hr style="border-top: 0.1px solid #cdcdcd; margin-top: 5px; margin-bottom: 10px;">

                                    <div style="display: flex; align-items: center; margin-bottom: 8px">
                                        <i class="ion-social-snapchat-outline"
                                            style="margin-right: 10px; font-size: 18px;"></i>
                                        <div class="memberNickname" id="memberNickname">${memberInfo.memberNickname}
                                        </div>
                                    </div>

                                    <div style="display: flex; align-items: center; margin-bottom: 8px">
                                        <i class="ion-iphone" style="margin-right: 17px; font-size: 18px;"></i>
                                        <div class="memberPh" id="memberPh">${memberInfo.memberPh}</div>
                                    </div>

                                    <div style="display: flex; align-items: center; margin-bottom: 8px">
                                        <i class="ion-ios-color-wand" style="margin-right: 12px; font-size: 18px;"></i>
                                        <div class="memberBirth" id="memberBirth">${memberInfo.memberBirth}</div>
                                    </div>

                                    <div style="display: flex; align-items: center; margin-bottom: 8px">
                                        <i class="ion-female" style="font-size: 18px;"></i><i class="ion-male"
                                            style="margin-right: 8px; font-size: 10px;"></i>
                                        <div class="memberGender" id="memberGender">${memberInfo.memberGender}</div>
                                    </div>

                                    <div style="display: flex; align-items: center; margin-bottom: 8px">
                                        <i class="ion-ribbon-b" style="margin-right: 13px; font-size: 18px;"></i>
                                        <div class="memberGrade" id="memberGrade">${memberInfo.memberGrade}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <chalKagTags:webFooter />

                <!-- JS -->
                <chalKagTags:webJs />

                <!-- XEIcons-->
                <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
            </body>
            <script>
                // 마이페이지 side바 하단 active Js
                document.addEventListener("DOMContentLoaded", function () {
                    // 현재 페이지의 URL을 가져옵니다.
                    var currentPage = window.location.href;

                    // 모든 메뉴 항목을 찾습니다.
                    var menuItems = document.querySelectorAll('li a');

                    // 각 메뉴 항목을 순회하면서
                    menuItems.forEach(function (item) {
                        // 만약 현재 페이지의 URL이 메뉴 항목의 href 속성과 일치한다면
                        if (currentPage.includes(item.getAttribute('href'))) {
                            // 해당 메뉴 항목에 'active' 클래스를 추가합니다.
                            item.classList.add('active');
                        } else {
                            // 일치하지 않는 경우, 'active' 클래스를 제거합니다.
                            item.classList.remove('active');
                        }
                    });
                });

                //이메일 마스킹
                document.addEventListener("DOMContentLoaded", function () {
        var memberIdElement = document.getElementById('memberId');
        var memberId = memberIdElement.innerText.trim();
        var atIndex = memberId.indexOf('@');
        if (atIndex !== -1) {
            var maskedId = memberId.substring(0, atIndex).replace(/./g, '*') + memberId.substring(atIndex);
            memberIdElement.innerText = maskedId;
        }
    });

    //전화번호 마스킹
    document.addEventListener("DOMContentLoaded", function () {
        var memberPhElement = document.getElementById('memberPh');
        var memberPh = memberPhElement.innerText.trim();
        if (memberPh.length === 11) {
            var maskedPh = memberPh.substring(0, 3) + '-****-' + memberPh.substring(7);
            memberPhElement.innerText = maskedPh;
        }
    });

             



            </script>


            </html>