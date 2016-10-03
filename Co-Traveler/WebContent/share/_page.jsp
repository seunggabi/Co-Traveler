<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="currentPage" value="${param.currentPage}" />   
<c:set var="url" value="${param.url}" />   
<c:set var="startPage" value="${param.startPage}" />
<c:set var="endPage" value="${param.endPage}" />
<c:set var="numPages" value="${param.numPages}" />
<c:set var="listType" value="${param.listType}" />
<c:set var="addOption" value="${param.addOption}" />
<c:set var="addValue" value="${param.addValue}" />
<div class="pagination pagination-centered">
	<ul>
    <c:choose>
      <c:when test="${1 >= currentPage}">
        <li class="disabled"><a href="#">&laquo;</a></li>
      </c:when>
      <c:otherwise>
      	     <c:choose>
		     	<c:when test="${addValue == null}">
        			<li><a href="${url}&${listType}page=${currentPage - 1}">&laquo;</a></li>
	        	</c:when>
				<c:otherwise>  
	        		<li><a href="${url}&${listType}page=${currentPage - 1}&${addOption}=${addValue}">${i}&laquo;</a></li>
		        </c:otherwise>
	        </c:choose>
      </c:otherwise>
    </c:choose>
    
    <c:forEach var="i" begin="${startPage}"  end="${endPage}">		
      <c:choose>
	      <c:when test="${i == currentPage}">
	     	<c:choose>
		     	<c:when test="${addValue == null}">
		        	<li class="active"><a href="${url}&${listType}page=${i}">${i}</a></li>
		        </c:when>
		        <c:otherwise>
		        	<li class="active"><a href="${url}&${listType}page=${i}&${addOption}=${addValue}">${i}</a></li>
		        </c:otherwise>
	        </c:choose>
	      </c:when>
	      <c:otherwise>
	     	<c:choose>
		     	<c:when test="${addValue == null}">
		        	<li><a href="${url}&${listType}page=${i}">${i}</a></li>
		        </c:when>
		        <c:otherwise>
		        	<li><a href="${url}&${listType}page=${i}&${addOption}=${addValue}">${i}</a></li>
		        </c:otherwise>
	        </c:choose>	      
	      </c:otherwise>
      </c:choose>
    </c:forEach>
	  
	  <c:choose>
      <c:when test="${currentPage >= numPages}">
        <li class="disabled"><a href="#">&raquo;</a></li>
      </c:when>
      <c:otherwise>
      	    <c:choose>
		     	<c:when test="${addValue == null}">
        			<li><a href="${url}&${listType}page=${currentPage + 1}">&raquo;</a></li>
	        	</c:when>
				<c:otherwise>        	
	        		<li><a href="${url}&${listType}page=${currentPage + 1}&${addOption}=${addValue}">${i}&raquo;</a></li>
	        	</c:otherwise>
	        </c:choose>
      </c:otherwise>
    </c:choose>
	</ul>
</div>