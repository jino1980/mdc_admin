<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!-- header -->
        <style type="text/css">
        body {
			  font-size: 14px;
			}
			
			.recipe { 
			  padding: 1em;
			}
			.recipe__title {
			  margin-top: 0;
			}
			.recipe__info {
			  vertical-align: top;
			  text-align: right;
			  padding: 0 1em 0 0;
			  margin: 0 1.3em 0 0;
			  font-weight: bold;
			  color: #454545;
			  border-right: 1px dotted #EEE;
			  width: 300px;
			  float: left;
			}
			.recipe__ingredients {
			  float: left;
			}
			.recipe-table {
			  position: relative;
			  padding:  1em;
			  border: 1px solid #DDD;
			  box-shadow: 0 15px 10px -10px rgba(31, 31, 31, 0.5);
			  z-index: 10;
			}
			
			.recipe-table__cell {
			  vertical-align: top;
			  padding: 3px 5px;
			}
			.recipe__text-field {
			  margin:0;
			  padding: .45em 0.92em;
			  font-size: 1em;
			  line-height: 1.4;
			  color: #555555;
			  background-color: #FFF;
			  background-image: none;
			  border: 1px solid #CCC;
			  border-left:1px solid #CCC;
			  
			}
			.recipe-table__add-row {
			  margin-top: 0;
			  position: relative;
			  border-top: 1px solid #EEE;
			  z-index: 8;
			}
			
			.recipe-table__add-row-btn {
			  display: block;
			  cursor: pointer;
			  position: absolute;
			  right: 0;
			  left: 0;
			  width: 4em;
			  margin: 0 auto;
			  -webkit-transition: all .2s easy-in;
			  transition: all .2s easy-in;
			  text-align: center;
			  opacity: 0.5;
			  color: #fff;
			  border: 1px solid #16A085;
			  border-bottom-right-radius: 1em;
			  border-bottom-left-radius: 1em;
			  background: #16A085;
			  height: 1.5em;
			  line-height: 1.5em;
			}
			.recipe-table__add-row-btn:hover {
			  opacity: 1;
			}
			
			.recipe-table__del-row-btn {
			  cursor: pointer;
			  display: inline-block;
			  padding: .45em 0.92em;
			  font-size: 1em;
			  line-height: 1.4;
			  border: 1px solid #F39C12;
			  color: #F39C12;
			  text-decoration: none;
			  transition: all .3s;
			  text-align: center;
			  background-color: #fff;
			}
			.recipe-table__del-row-btn:hover {
			  background: #F39C12;
			  color: #fff;
			}
			
			
			.drag-handler {
			  width: 1.4em;
			  position: relative;
			  background-color: #E4E6EB;
			  background-image: linear-gradient(45deg, #E4E6EB, #E4E6EB 2px, #fff 2px, #fff 4px, #E4E6EB 4px, #E4E6EB 9px, #fff 9px, #fff 11px, #E4E6EB 11px, #E4E6EB 16px, #fff 16px, #fff 18px, #E4E6EB 18px, #E4E6EB 22px);
			  background-size: 10px 20px; 
			  cursor: move;
			  border-top: 2px solid #FFF;
			  border-bottom: 2px solid #FFF;
			}
			
			.drag-handler:active {
			  background-image: linear-gradient(45deg, #bab86c, #bab86c 2px, #fff 2px, #fff 4px, #bab86c 4px, #bab86c 9px, #fff 9px, #fff 11px, #bab86c 11px, #bab86c 16px, #fff 16px, #fff 18px, #bab86c 18px, #bab86c 22px);
			  background-size: 10px 20px; 
			}
        </style>
        <script src="${RESOURCES_PATH}/resource/js/Sortable.js"></script>
        
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
                

				<div class="recipe">
				  
				  <div class="recipe__info">
				    <h2 class="recipe__title"></h2>
				    <p></p>
				  </div>
				  
				  
				  <div class="recipe__ingredients">
				    <table cellpadding="0" cellspacing="0" border="0" class="recipe-table" id="recipeTable">
				      <tbody id="recipeTableBody">
				        <tr>
				          <td class="drag-handler"></td>
				          <td class="recipe-table__cell" width="70%">
				            <input type="text" class="recipe__text-field" value="Large bananas" placeholder=":::카테고리명 입력:::">
				          </td>
				          <td class="recipe-table__cell">
				            <input type="text" class="recipe__text-field" value="3" placeholder="소팅?">
				          </td>
				          <td class="recipe-table__cell">
				            <button class="recipe-table__del-row-btn">x</button>
				          </td>
				        </tr>
				        <tr>
				          <td class="drag-handler"></td>
				          <td class="recipe-table__cell" width="35%">
				            <input type="text" class="recipe__text-field" value="White sugar" placeholder=":::카테고리명 입력:::">
				          </td>
				          <td class="recipe-table__cell">
				            <input type="text" class="recipe__text-field" value="¹⁄₂" placeholder="Value">
				          </td>
				          <td class="recipe-table__cell">
				            <button class="recipe-table__del-row-btn">x</button>
				          </td>
				        </tr>
				        <tr>
				          <td class="drag-handler"></td>
				          <td class="recipe-table__cell">
				            <input type="text" class="recipe__text-field" value="Egg" placeholder=":::카테고리명 입력:::">
				          </td>
				          <td class="recipe-table__cell">
				            <input type="text" class="recipe__text-field" value="1" placeholder="Value">
				          </td>
				          <td class="recipe-table__cell">
				            <button class="recipe-table__del-row-btn">x</button>
				          </td>
				        </tr>
				      </tbody>
				    </table>
				    <div class="recipe-table__add-row">
				      <!-- <span class="recipe-table__add-row-btn">+</span> -->
				    </div>
				    <div class="paging_box">
	                    <div class="btn_box">
	                        <button type="button" class="btn btn_default" name"btnAdd" onClick="javascript:fnAdd();" >추가</button>
	                        <button type="button" class="btn btn_default">저장</button>
	                    </div>
	                </div>
				  </div>
				</div>
				<script id="rowTemplate" type="text/template">
    				<tr>
        				<td class="drag-handler"></td>
        				<td class="recipe-table__cell">
            				<input type="text" class="recipe__text-field" value="" placeholder=":::카테고리명 입력:::">
        				</td>
        				<td class="recipe-table__cell">
            				<input type="text" class="recipe__text-field" value="" placeholder="Value">
        				</td>
        				<td class="recipe-table__cell">
           					 <button class="recipe-table__del-row-btn">x</button>
        				</td>
    				</tr>
				</script>



                <!-- // 카테고리 리스트 -->
                <!-- 페이징 + 버튼 -->
                
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->


    <script>
    
    
	    $(document).ready(function () {
	    	  var $tableBody = $('#recipeTableBody');
	    	  var $menu = $('#menu');
	    	    
	    	  	$(document).on('click', 'button[name="btnAdd"]', function (e) { alert(111);
	    	  	//$(document).on('click', '.recipe-table__add-row-btn', function (e) {
	    	        var $el = $(e.currentTarget);
	    	        var htmlString = $('#rowTemplate').html();
	    	        $tableBody.append(htmlString);
	    	        return false;
	    	    });
	
	    	    $tableBody.on('click', '.recipe-table__del-row-btn', function (e) {
	    	        var $el = $(e.currentTarget);
	    	        var $row = $el.closest('tr');
	    	        $row.remove();
	    	        return false;
	    	    });
	    	  Sortable.create(
	    	        $tableBody[0],
	    	        {
	    	            animation: 150,
	    	            scroll: true,
	    	            handle: '.drag-handler',
	    	            onEnd: function () {
	    	                console.log('More see in https://github.com/RubaXa/Sortable');
	    	            }
	    	        }
	    	    );
	    	});
	    	  	
	    // 추가
		function fnAdd(){
			var htmlString = $('#rowTemplate').html();
			$('#recipeTableBody').append(htmlString);
		}
    </script>