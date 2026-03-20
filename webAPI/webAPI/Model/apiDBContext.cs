using Microsoft.EntityFrameworkCore;

namespace webAPI.Model
{
    public class apiDBContext:DbContext
    {
        public apiDBContext(DbContextOptions option):base(option) 
        { 
            
        }

        public DbSet<users> users { get; set; }
    }
}
