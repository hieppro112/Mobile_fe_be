namespace webAPI.Model
{
    public class ApiResponse<T>
    {
        private bool success;
        private String message;
        private T data;

        public bool Success { get => success; set => success = value; }
        public string Message { get => message; set => message = value; }
        public T Data { get => data; set => data = value; }
    }
}
