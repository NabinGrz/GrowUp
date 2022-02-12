using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class AddSkillCategory : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "SkillCategoryId",
                table: "Skills",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "SkillCateogries",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SkillCateogries", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Skills_SkillCategoryId",
                table: "Skills",
                column: "SkillCategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_SkillCateogries_SkillCategoryId",
                table: "Skills",
                column: "SkillCategoryId",
                principalTable: "SkillCateogries",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Skills_SkillCateogries_SkillCategoryId",
                table: "Skills");

            migrationBuilder.DropTable(
                name: "SkillCateogries");

            migrationBuilder.DropIndex(
                name: "IX_Skills_SkillCategoryId",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "SkillCategoryId",
                table: "Skills");
        }
    }
}
