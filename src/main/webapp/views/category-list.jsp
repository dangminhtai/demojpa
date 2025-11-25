<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Category Management</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h2 class="text-center mb-4">Category Management</h2>

                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/category/create" class="btn btn-success">Add New
                        Category</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary float-end">Logout</a>
                </div>

                <div class="card">
                    <div class="card-header">Category List</div>
                    <div class="card-body">
                        <c:if test="${not empty message}">
                            <div class="alert alert-success">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Code</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${list}">
                                    <tr>
                                        <td>${item.categoryId}</td>
                                        <td>${item.categoryname}</td>
                                        <td>${item.categorycode}</td>
                                        <td>${item.status == 1 ? 'Active' : 'Inactive'}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/category/update?id=${item.categoryId}"
                                                class="btn btn-sm btn-warning">Edit</a>
                                            <a href="${pageContext.request.contextPath}/category/delete?id=${item.categoryId}"
                                                class="btn btn-sm btn-danger"
                                                onclick="return confirm('Are you sure?')">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </body>

        </html>