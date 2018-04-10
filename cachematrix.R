## These functions will allow you to store a cached inverse for a matrix which has already had it's inverse calculated

## This function will calculate the inverse matrix of the input matrix x. The inverse matrix will be stored in cache.
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
      x <<- y
      inv <<- NULL
    }
    get <- function() x
    setinv <- function(solve) inv <<- solve
    getinv <- function() inv
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## Return a matrix that is the inverse of 'x', if inverse of x is already stored in cache, the inverse will be returned from chache. Otherwise inverse will be calculated and stored in the cache.

cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv
}
