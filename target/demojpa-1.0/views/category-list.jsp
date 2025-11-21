<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
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

                <div class="row">
                    <!-- Form Section -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                ${not empty category.categoryId && category.categoryId > 0 ? 'Edit Category' : 'New
                                Category'}
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty message}">
                                    <div class="alert alert-success">${message}</div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form
                                    action="${pageContext.request.contextPath}/categories/${not empty category.categoryId && category.categoryId > 0 ? 'update' : 'create'}"
                                    method="post">
                                    <input type="hidden" name="categoryId" value="${category.categoryId}">

                                    <div class="mb-3">
                                        <label class="form-label">Category Name</label>
                                        <input type="text" class="form-control" name="categoryname"
                                            value="${category.categoryname}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Category Code</label>
                                        <input type="text" class="form-control" name="categorycode"
                                            value="${category.categorycode}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Images (URL)</label>
                                        <input type="text" class="form-control" name="images"
                                            value="${category.images}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Status</label>
                                        <select class="form-select" name="status">
                                            <option value="1" ${category.status==1 ? 'selected' : '' }>Active</option>
                                            <option value="0" ${category.status==0 ? 'selected' : '' }>Inactive</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save</button>
                                    <a href="${pageContext.request.contextPath}/categories/reset"
                                        class="btn btn-secondary">Reset</a>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- List Section -->
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">Category List</div>
                            <div class="card-body">
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
                                                    <a href="${pageContext.request.contextPath}/categories/update?id=${item.categoryId}"
                                                        class="btn btn-sm btn-warning">Edit</a>
                                                    <a href="${pageContext.request.contextPath}/categories/delete?id=${item.categoryId}"
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
                </div>
            </div>
        </body>

        </html>