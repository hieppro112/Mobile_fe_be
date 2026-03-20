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


//sql server connect
//builder.Services.AddDbContext<apiDBContext>(option =>
//    option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"))
//);

//conect PostgreSQL
builder.Services.AddDbContext<apiDBContext>(options =>
{
    var connectionString = Environment.GetEnvironmentVariable("postgresql://postgres:mRjMLpXQMFfauQOfrRSVpngzuqykkpKP@postgres.railway.internal:5432/railway");

    if (string.IsNullOrEmpty(connectionString))
    {
        // 👉 chạy local
        connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
        options.UseSqlServer(connectionString);
    }
    else
    {
        // 👉 chạy Railway
        var uri = new Uri(connectionString);
        var userInfo = uri.UserInfo.Split(':');

        var connStr = $"Host={uri.Host};Port={uri.Port};Database={uri.AbsolutePath.TrimStart('/')};Username={userInfo[0]};Password={userInfo[1]}";

        options.UseNpgsql(connStr);
    }
});

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

// ❌ KHÔNG cần cái này nữa
// builder.WebHost.UseUrls(...);

// Swagger (luôn bật)
app.UseSwagger();
app.UseSwaggerUI();

// app.UseHttpsRedirection();

app.UseCors("AllowAll");

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<apiDBContext>();
    db.Database.Migrate();
}

app.Run();