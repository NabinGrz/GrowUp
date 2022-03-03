using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class ChangeTestToTextINOption : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Test",
                table: "Options",
                newName: "Text");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Text",
                table: "Options",
                newName: "Test");
        }
    }
}
