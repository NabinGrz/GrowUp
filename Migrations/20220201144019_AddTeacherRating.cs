using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class AddTeacherRating : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<float>(
                name: "Rating",
                table: "Videos",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.AddColumn<float>(
                name: "TeacherRatingId",
                table: "AspNetUsers",
                type: "real",
                nullable: false,
                defaultValue: 0f);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Rating",
                table: "Videos");

            migrationBuilder.DropColumn(
                name: "TeacherRatingId",
                table: "AspNetUsers");
        }
    }
}
