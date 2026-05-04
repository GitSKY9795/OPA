package auth

default allow := false

# Instructors can create, update, and delete their own courses.
allow if {
    input.user.role == "instructor"
    input.course.owner_id == input.user.id
    input.action == "create"
}

allow if {
    input.user.role == "instructor"
    input.course.owner_id == input.user.id
    input.action == "update"
}

allow if {
    input.user.role == "instructor"
    input.course.owner_id == input.user.id
    input.action == "delete"
    not input.course.published
}

# Students can only view enrolled courses.
allow if {
    input.user.role == "student"
    input.action == "view"
    input.course.enrolled == true
}

# Guests can only view free courses.
allow if {
    input.user.role == "guest"
    input.action == "view"
    input.course.price == 0
}
