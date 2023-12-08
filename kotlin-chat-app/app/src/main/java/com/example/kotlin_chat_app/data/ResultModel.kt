sealed class ResultQuery<out R> {

    data class Success<out T>(val data: T?) : ResultQuery<T>()
    data class Error(val exception: Exception) : ResultQuery<Nothing>()
    object Loading : ResultQuery<Nothing>()

    override fun toString(): String {
        return when (this) {
            is Success<*> -> "Success[data=$data]"
            is Error -> "Error[exception=$exception]"
            is Loading -> "Loading"
            else -> "Loading"
        }
    }
}
