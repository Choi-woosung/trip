<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>schedule</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <!-- <link rel='stylesheet' type='text/css' media='screen' href='main.css'> -->
    <!-- <script src='main.js'></script> -->
    <style>
        /* all s */
        *{
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            list-style: none;
            border: none;
            outline: none;
            color: #8EC0E4;
        }
        /* all e */

        /* body s */
        .mainBody{
            background-color: #6AAFE6;
        }
        /* body e */

        /* main s */
        .mainBox{
            width: 100%;
            height: 100vh;
        }
        /* main e */

        /* schedule s */
        .scheduleBox{
            width: 85%;
            height: 100%;
            float: left;
        }
        .schedule{
            width: 42.5%;
            min-height: 425px;
            height: auto;
            margin: 0 auto;
            background-color: #CADBE9;
            margin-top: 2.5%;
            margin-bottom: 2.5%;
            padding-bottom: 2.5%;
            border-radius: 16px;
        }
        .toDay{
            font-weight: bold;
            user-select: none;
            text-align: center;
            font-size: 2rem;
        }
        .elCls{
            display: block;
            min-width: 90%;
            max-width: 90%;
            min-height: 5vh;
            height: auto;
            margin: 0 auto;
            margin-top: 2.5%;
            margin-bottom: 2.5%;
            border-radius: 16px;
            padding: 8px;
            font-size: 1.25rem;
            font-weight: bold;
        }
        /* schedule e */

        /* sidebar s */
        .sidebarBox{
            position: fixed;
            top: 0;
            right: 0;
            width: 15%;
            height: 100%;
            background-color: #D4DFE6;
        }
        .sidebar img{
            display: block;
            width: 100px;
            height: 100px;
            margin: 5% auto;
        }
        .sidebar li {
            display: block;
        }
        .saveBtn{
            display: block;
            width: 80%;
            height: 80px;
            margin: 0 auto;
            font-size: 1.5rem;
            font-weight: bold;
            border-radius: 16px;
        }
        /* sidebar e */

        /* del s */
        .del{
            display: none;
        }
        /* del e */
    </style>
</head>
<body class="mainBody">
    <!-- main s -->
    <div class="mainBox" dropzone="true">
        <!-- schedule s -->
        <ul class="scheduleBox">
            <li class="schedule">
                <div class="toDay">Day 1</div>
            </li>
            <li class="schedule">
                <div class="toDay">Day 2</div>
            </li>
            <li class="schedule">
                <div class="toDay">Day 3</div>
            </li>
        </ul>
        <!-- schedule e -->

        <!-- sidebar s -->
        <div class="sidebarBox">
            <!-- side s -->
            <ul class="sidebar">
                <li>
                    <img src="/img/schedule/hotel.jpg" alt="hotel">
                </li>
                <li>
                    <img src="/img/schedule/restaurant.jpg" alt="restaurant">
                </li>
                <li>
                    <img src="/img/schedule/taxi.jpg" alt="taxi">
                </li>
                <li>
                    <img src="/img/schedule/text.jpg" alt="text">
                </li>
                <li>
                    <img src="" alt="">
                </li>
            </ul>
            <!-- side e -->

            <!-- menu s -->
            <ul class="menu">
                <li>
                    <input type="button" class="saveBtn" value="저장하기">
                </li>
            </ul>
            <!-- menu e -->
        </div>
        <!-- sidebar e -->
    </div>
    <!-- main e -->

    <!-- del s -->
    <div class="del"></div>
    <!-- del e -->

    <!-- mainScript s -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // all s
            localStorage.removeItem('cnt');
            // all e

            // var s
            const mainBox = id('.mainBox');
            const schedule = document.getElementsByClassName('schedule');
            const sidebar = id('.sidebar');
            const saveBtn = id('.saveBtn');
            const del = id('.del');
            let cnt = localStorage.getItem('cnt');
            // var e

            // if s
            if (cnt == undefined) {
                localStorage.setItem('cnt', 0);
                cnt = localStorage.getItem('cnt');
            }
            // if e

            // for s
            for (let i = 0; i < sidebar.children.length; i++) {
                let id = sidebar.children[i].firstElementChild;
                id.setAttribute('draggable', true);
                evt(id, 'dragstart', dragstart_);
            }
            for (let i = 0; i < schedule.length; i++) {
                schedule[i].setAttribute('dropzone', true);
                evt(schedule[i], 'dragover', dragover_);
                evt(schedule[i], 'drop', drop_);
                evt(schedule[i], 'dragstart', dragstart_);
            }
            // for e

            // event s
            evt(sidebar, 'dragstart', dragstart_);
            evt(saveBtn, 'click', saveEvt);
            evt(mainBox, 'dragover', dragover_);
            evt(mainBox, 'drop', drop_box);
            // event e

            // function s
            // querySelector
            function id(id = new String) {
                return document.querySelector(id);
            }
            // addEventListener
            function evt(id = new Object, evt = new String, fun = new Function) {
                id.addEventListener(evt, fun);
            }
            // dragstart_ 
            function dragstart_(e) {
                let id = e.target;
                e.dataTransfer.setData('alt', id.getAttribute('alt'));
            }
            function dragover_(e) {
                e.preventDefault();
            }
            function drop_(e) {
                e.preventDefault();
                let id = e.dataTransfer.getData('alt');
                let el = getEl(id);

                this.appendChild(el);
            }
            // menu event
            function getEl(id){
                let attr;

                cnt++;

                switch (id) {
                    case 'hotel':
                        attr = createEl('textarea');
                        break;
                    case 'restaurant':
                        attr = createEl('textarea');
                        break;
                    case 'taxi':
                        attr = createEl('textarea');
                        break;
                    case 'text':
                        attr = createEl('textarea');
                        break;
                }

                if (attr != undefined) {
                    attr.setAttribute('alt', 'el' + cnt);                    
                    attr.setAttribute('draggable', true);
                    attr.setAttribute('class', 'elCls');
                }

                return attr;
            }
            function createEl(id){
                return document.createElement(id);
            }
            function saveEvt(){
                location.href = '/schedule/scheduleList.kit';
            }
            function drop_box(e){
                e.preventDefault();
                let id = e.dataTransfer.getData('alt');
                let el = document.querySelector('[alt=' + id +']');
                console.log(id);
                
                if (id == 'el' + cnt) {
                    if (el != undefined) {
                        el.style.display = 'none';
                        del.appendChild(el);
                        del.removeChild(el);
                    }
                }
            }
            // function e
        });
    </script>
    <!-- mainScript e -->
</body>
</html>
