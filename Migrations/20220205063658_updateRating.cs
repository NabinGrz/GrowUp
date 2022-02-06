using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class updateRating : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TeacherRatingId",
                table: "AspNetUsers");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<float>(
                name: "TeacherRatingId",
                table: "AspNetUsers",
                type: "real",
                nullable: false,
                defaultValue: 0f);
        }
    }
}
