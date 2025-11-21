<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Video Management</title>
        </head>

        <body>
            <div class="container mt-5">
                <h2 class="text-center mb-4">Video Management</h2>

                <div class="row">
                    <!-- Form Section -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                ${not empty video.videoId ? 'Edit Video' : 'New Video'}
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty message}">
                                    <div class="alert alert-success">${message}</div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form
                                    action="${pageContext.request.contextPath}/videos/${not empty video.videoId ? 'update' : 'create'}"
                                    method="post">
                                    <div class="mb-3">
                                        <label class="form-label">Video ID</label>
                                        <input type="text" class="form-control" name="videoId" value="${video.videoId}"
                                            ${not empty video.videoId ? 'readonly' : '' } required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Title</label>
                                        <input type="text" class="form-control" name="title" value="${video.title}"
                                            required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Poster (URL)</label>
                                        <input type="text" class="form-control" name="poster" value="${video.poster}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Views</label>
                                        <input type="number" class="form-control" name="views" value="${video.views}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea class="form-control"
                                            name="description">${video.description}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Active</label>
                                        <select class="form-select" name="active">
                                            <option value="1" ${video.active==1 ? 'selected' : '' }>Active</option>
                                            <option value="0" ${video.active==0 ? 'selected' : '' }>Inactive</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Category</label>
                                        <select class="form-select" name="categoryId">
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.categoryId}"
                                                    ${video.category.categoryId==cat.categoryId ? 'selected' : '' }>
                                                    ${cat.categoryname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save</button>
                                    <a href="${pageContext.request.contextPath}/videos/reset"
                                        class="btn btn-secondary">Reset</a>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- List Section -->
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span>Video List</span>
                                    <form action="${pageContext.request.contextPath}/videos" method="get"
                                        class="d-flex">
                                        <input class="form-control me-2" type="search" name="keyword"
                                            placeholder="Search" aria-label="Search">
                                        <button class="btn btn-outline-success" type="submit">Search</button>
                                    </form>
                                </div>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Views</th>
                                            <th>Active</th>
                                            <th>Category</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${list}">
                                            <tr>
                                                <td>${item.videoId}</td>
                                                <td>${item.title}</td>
                                                <td>${item.views}</td>
                                                <td>${item.active == 1 ? 'Active' : 'Inactive'}</td>
                                                <td>${item.category.categoryname}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/videos/update?id=${item.videoId}"
                                                        class="btn btn-sm btn-warning">Edit</a>
                                                    <a href="${pageContext.request.contextPath}/videos/delete?id=${item.videoId}"
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