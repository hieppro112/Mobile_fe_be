using System.ComponentModel.DataAnnotations;

namespace webAPI.Model
{
    public class users
    {
        [Key]
        public int userID { get; set; }

        [Required]
        public String userName { get; set; } = "";
        [Required]
        public string address { get; set; } = "";
    }
}
