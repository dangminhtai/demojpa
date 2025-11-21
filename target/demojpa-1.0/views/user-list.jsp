<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>User Management</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <h2 class="text-center mb-4">User Management</h2>

                <div class="row">
                    <!-- Form Section -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                ${not empty user.id && user.id > 0 ? 'Edit User' : 'New User'}
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty message}">
                                    <div class="alert alert-success">${message}</div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form
                                    action="${pageContext.request.contextPath}/users/${not empty user.id && user.id > 0 ? 'update' : 'create'}"
                                    method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="id" value="${user.id}">
                                    <input type="hidden" name="currentImage" value="${user.images}">

                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" name="username" value="${user.username}"
                                            required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" class="form-control" name="password"
                                            value="${user.password}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Fullname</label>
                                        <input type="text" class="form-control" name="fullname" value="${user.fullname}"
                                            required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" name="email" value="${user.email}"
                                            required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Phone</label>
                                        <input type="text" class="form-control" name="phone" value="${user.phone}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Images</label>
                                        <input type="file" class="form-control" name="images">
                                        <c:if test="${not empty user.images}">
                                            <img src="${pageContext.request.contextPath}/${user.images}" alt="Avatar"
                                                width="100" class="mt-2">
                                        </c:if>
                                    </div>

                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" name="admin" id="admin"
                                            ${user.admin ? 'checked' : '' }>
                                        <label class="form-check-label" for="admin">Admin</label>
                                    </div>

                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" name="active" id="active"
                                            ${user.active ? 'checked' : '' }>
                                        <label class="form-check-label" for="active">Active</label>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save</button>
                                    <a href="${pageContext.request.contextPath}/users/reset"
                                        class="btn btn-secondary">Reset</a>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- List Section -->
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">User List</div>
                            <div class="card-body">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Fullname</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${list}">
                                            <tr>
                                                <td>${item.id}</td>
                                                <td>${item.username}</td>
                                                <td>${item.fullname}</td>
                                                <td>${item.email}</td>
                                                <td>${item.phone}</td>
                                                <td>${item.admin ? 'Admin' : 'User'}</td>
                                                <td>${item.active ? 'Active' : 'Inactive'}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/users/update?id=${item.id}"
                                                        class="btn btn-sm btn-warning">Edit</a>
                                                    <a href="${pageContext.request.contextPath}/users/delete?id=${item.id}"
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