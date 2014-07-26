##My functions allow me to always maintain an up to date inverse matrix in my cache or global environment. If there is currently no inverse matrix, my first function makeCacheMatrix splits into functions that set and get my inverses, and my second function cachesolve creates new inverses.

## This is a function clearly defined on matrices x, and not numerics/vectors x

makeCacheMatrix <- function(x = matrix()) {
 i <- NULL #Defines i as the undefined inverse matrix object
        set <- function(y) #The set function sets the inverse of the matrix x. Here x is y, y is the universal matrix variable
       {
                x <<- y 
                i <<- NULL
        }
        get <- function() x #Here you can get the inverse of the matrix from the cache
        setinverse <- function(inverse) i <<- inverse
        getinverse <- function() i
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse) #Here we have a list of functions which makeCacheMatrix can turn something into
}


## This defines the cacheSolve function which obtains the inverse of a matrix X in the cache

cacheSolve <- function(x, ...) {
        i <- x$getinverse() #We first see what the current inverse in the cache is. getinverse(y)?
        if(!is.null(i)) {
                message("getting cached inverse matrix")
                return(i)
        }
        data <- x$get() #The inverse of the matrix from the cache is got, and called data as it is this is in the case where i is null
        i <- solve(data, ...) #Computes the inverse of the matrix, currently "data", which is currently not in the cache
        x$setinverse(i) #Sets the value of the inverse matrix in the cache via setinverse function
        i #That becomes the new inverse
}
