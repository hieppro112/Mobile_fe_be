using Microsoft.EntityFrameworkCore;
using webAPI.Model;

var builder = WebApplication.CreateBuilder(args);

// ✅ FIX PORT (Railway)
var port = Environment.GetEnvironmentVariable("PORT");
if (!string.IsNullOrEmpty(port))
{
    builder.WebHost.UseUrls($"http://0.0.0.0:{port}");
}

// Add services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// ✅ DATABASE CONFIG (LOCAL + RAILWAY)
builder.Services.AddDbContext<apiDBContext>(options =>
{
    var databaseUrl = Environment.GetEnvironmentVariable("DATABASE_URL");

    Console.WriteLine("DATABASE_URL: " + databaseUrl);

    if (string.IsNullOrEmpty(databaseUrl))
    {
        // 👉 LOCAL (SQL Server)
        options.UseSqlServer(
            builder.Configuration.GetConnectionString("DefaultConnection"),
            sql => sql.EnableRetryOnFailure()
        );
    }
    else
    {
        // 👉 RAILWAY (PostgreSQL)
        var uri = new Uri(databaseUrl);
        var userInfo = uri.UserInfo.Split(':');

        var connStr =
            $"Host={uri.Host};" +
            $"Port={uri.Port};" +
            $"Database={uri.AbsolutePath.TrimStart('/')};" +
            $"Username={userInfo[0]};" +
            $"Password={userInfo[1]};" +
            $"SSL Mode=Require;" +
            $"Trust Server Certificate=true";

        options.UseNpgsql(connStr);
    }
});

// ✅ CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// ✅ Swagger (luôn bật)
app.UseSwagger();
app.UseSwaggerUI();

app.UseCors("AllowAll");

app.UseAuthorization();

app.MapControllers();

// ✅ AUTO MIGRATE (QUAN TRỌNG)
using (var scope = app.Services.CreateScope())
{
    try
    {
        var db = scope.ServiceProvider.GetRequiredService<apiDBContext>();
        Console.WriteLine("Applying migrations...");
        db.Database.Migrate();
        Console.WriteLine("Database migrated successfully!");
    }
    catch (Exception ex)
    {
        Console.WriteLine("Migration failed: " + ex.Message);
    }
}

app.Run();