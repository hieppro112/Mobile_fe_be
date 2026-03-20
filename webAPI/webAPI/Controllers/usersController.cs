using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using webAPI.Model;

namespace webAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class usersController : ControllerBase
    {
        private readonly apiDBContext _context;

        public usersController(apiDBContext context)
        {
            _context = context;
        }

        // GET: api/users
        [HttpGet]
        public async Task<ActionResult<IEnumerable<users>>> Getusers()
        {
            List<users> listUS = await _context.users.ToListAsync();
            return Ok(new ApiResponse<List<users>>
            {
                Success = true,
                Message = "Get data success ",
                Data = listUS

            });

        }

        // GET: api/users/5
        [HttpGet("{id}")]
        public async Task<ActionResult<users>> Getusers(int id)
        {
            var users = await _context.users.FindAsync(id);

            if (users == null)
            {
                return NotFound();
            }

            return users;
        }

        // PUT: api/users/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> Putusers(int id, users users)
        {
            if (id != users.userID)
            {
                return BadRequest();
            }

            _context.Entry(users).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!usersExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/users
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<users>> Postusers(users users)
        {
            _context.users.Add(users);
            await _context.SaveChangesAsync();

            return CreatedAtAction("Getusers", new { id = users.userID }, new ApiResponse<users>{
                Data = users,
                Message = "add data success",
                Success = true
            });
        }

        // DELETE: api/users/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<users>> Deleteusers(int id)
        {
            var users = await _context.users.FindAsync(id);
            if (users == null)
            {
                return NotFound(
                    new ApiResponse<users>
                    {
                        Success = false,
                        Data = null,
                        Message = $"Not Found id: {id}"
                    }
                    );
            }

            _context.users.Remove(users);
            await _context.SaveChangesAsync();

            return Ok(
                new ApiResponse<users>
                {
                    Success = true,
                    Data = users,
                    Message = "Delete Success"

                }
                );
        }

        private bool usersExists(int id)
        {
            return _context.users.Any(e => e.userID == id);
        }
    }
}
