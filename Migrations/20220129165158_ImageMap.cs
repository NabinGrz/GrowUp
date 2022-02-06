using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class ImageMap : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_NewsFeeds_AspNetUsers_ApplicationId",
                table: "NewsFeeds");

            migrationBuilder.DropIndex(
                name: "IX_NewsFeeds_ApplicationId",
                table: "NewsFeeds");

            migrationBuilder.DropColumn(
                name: "ApplicationId",
                table: "NewsFeeds");

            migrationBuilder.RenameColumn(
                name: "Image",
                table: "NewsFeeds",
                newName: "ImageUrl");

            migrationBuilder.AlterColumn<string>(
                name: "Title",
                table: "NewsFeeds",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ApplicationUserId",
                table: "NewsFeeds",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateIndex(
                name: "IX_NewsFeeds_ApplicationUserId",
                table: "NewsFeeds",
                column: "ApplicationUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_NewsFeeds_AspNetUsers_ApplicationUserId",
                table: "NewsFeeds",
                column: "ApplicationUserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_NewsFeeds_AspNetUsers_ApplicationUserId",
                table: "NewsFeeds");

            migrationBuilder.DropIndex(
                name: "IX_NewsFeeds_ApplicationUserId",
                table: "NewsFeeds");

            migrationBuilder.RenameColumn(
                name: "ImageUrl",
                table: "NewsFeeds",
                newName: "Image");

            migrationBuilder.AlterColumn<string>(
                name: "Title",
                table: "NewsFeeds",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<int>(
                name: "ApplicationUserId",
                table: "NewsFeeds",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ApplicationId",
                table: "NewsFeeds",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_NewsFeeds_ApplicationId",
                table: "NewsFeeds",
                column: "ApplicationId");

            migrationBuilder.AddForeignKey(
                name: "FK_NewsFeeds_AspNetUsers_ApplicationId",
                table: "NewsFeeds",
                column: "ApplicationId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
