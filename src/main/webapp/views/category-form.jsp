<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>${not empty category.categoryId && category.categoryId > 0 ? 'Edit Category' : 'New Category'}
            </title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                ${not empty category.categoryId && category.categoryId > 0 ? 'Edit Category' : 'New
                                Category'}
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form
                                    action="${pageContext.request.contextPath}/category/${not empty category.categoryId && category.categoryId > 0 ? 'update' : 'create'}"
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
                                    <a href="javascript:history.back()" class="btn btn-secondary">Cancel</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>