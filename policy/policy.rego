package main

# Deny if the course price is invalid.
deny contains msg if {
    input.course_price < 0
    msg = "course_price must be zero or greater"
}

# Deny if published content is missing.
deny contains msg if {
    input.isPublished == true
    input.content_missing == true
    msg = "Published content cannot be missing"
}

# Deny if environment is not production.
deny contains msg if {
    input.env != "prod"
    msg = "Deployment from dev environment is not allowed"
}