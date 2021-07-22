<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!-- header -->
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">카테고리 관리</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->

            <div class="content">
                <!-- 카테고리 리스트 -->
                <div id="tree" class="tui-tree-wrap"></div>
                <!-- // 카테고리 리스트 -->
                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" id="addChildBtn">추가</button>
                        <button type="button" class="btn btn_default">저장</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->


    <script>
        var util = {
            addEventListener: function (element, eventName, handler) {
                if (element.addEventListener) {
                    element.addEventListener(eventName, handler, false);
                } else {
                    element.attachEvent('on' + eventName, handler);
                }
            }
        };

        var data = [{
                text: '생명과학'
            },
            {
                text: '화학'
            },
            {
                text: '재료과학'
            }
        ];

        var movedValue = document.getElementById('movedValue');

        var tree = new tui.Tree('tree', {
            data: data,
            nodeDefaultState: 'opened'
        }).enableFeature('Draggable', {
            helperClassName: 'tui-tree-drop',
            lineClassName: 'tui-tree-line',
            isSortable: true
        }).enableFeature('Editable', {
            dataKey: 'text'
        }).enableFeature('ContextMenu', {
            menuData: [{
                title: '삭제'
            }]
        })

        tree.on('beforeOpenContextMenu', function (nodeId) {
            var menuData = [{
                title: '삭제'
            }];
            tree.changeContextMenu(menuData); // change menu api
        });


        tree.on('move', function (eventData) {
            var msg;

            msg = 'nodeId: ' + eventData.nodeId + '\n';
            msg += 'originalParentId: ' + eventData.originalParentId + '\n';
            msg += 'newParentId: ' + eventData.newParentId + '\n';
            msg += 'index: ' + eventData.index + '\n';

            movedValue.value = msg;
        });

        var addBtn = document.getElementById('addChildBtn');
        var removeBtn = document.getElementById('removeChildBtn');
        var rootNodeId = tree.getRootNodeId();

        util.addEventListener(addBtn, 'click', function () {
            tree.add({
                text: '새 카테고리'
            }, rootNodeId);
        });
    </script>