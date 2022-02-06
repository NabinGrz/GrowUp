using Growup.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Growup.Data
{
    public class GrowupDbContext : IdentityDbContext<ApplicationUser>
    {
        public GrowupDbContext(DbContextOptions<GrowupDbContext> options) : base(options)
        {

        }

        public DbSet<Comment> Comments { get; set; }
        public DbSet<Videos> Videos{ get; set; }
        public DbSet<Skill> Skills { get; set; }
        public DbSet<NewsFeed> NewsFeeds { get; set; }
    }
}
