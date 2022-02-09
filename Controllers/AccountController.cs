using Growup.DTOs;
using Growup.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Controllers
{
    public class AccountController : ControllerBase
    {
        private IUserService _userService;
        private IMailService _mailService;
        public AccountController(IUserService userService,
                                 IMailService mailService)
        {
            _userService = userService;
            _mailService = mailService;
        }
      
        // /api/account/register
        [HttpPost("/api/v1/account/register")]
        public async Task<IActionResult> RegisterAsync([FromBody] RegisterViewModel model)
        {

            if (ModelState.IsValid)
            {
                var result = await _userService.RegisterUserAsync(model);
                if (result.IsSuccess)
                {
                    return Ok(result);
                }
                return BadRequest(result);
            }
            return BadRequest("Some properties are not valid");//Status : 400
        }

        // /api/v1/account/login
        [HttpPost("/api/v1/account/login")]
        public async Task<IActionResult> LoginAsync([FromBody]LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var result = await _userService.LoginUserAsync(model);
                if (result.IsSuccess)
                {
                    await _mailService.SendEmailAsync(model.Email, "Login Notice", "<h1> Your account was loggedin</h1>");
                    return Ok(result);
                }
            }
            return BadRequest("Some properties are not valid");
        }


        // /api/v1/account/confirmemail?userid&token
        [HttpGet("/api/v1/account/confirmEmail")]
        public async Task<IActionResult> ActionResult(string userId, string token)
        {
            if(string.IsNullOrWhiteSpace(userId) || string.IsNullOrWhiteSpace("token"))
            {
                return NotFound();
            }
            var result = await _userService.ConfirmEmailAsync(userId, token);
            if (result.IsSuccess)
            {
                return Ok(result);
            }
            return BadRequest(result);
        }

        // /api/v1/account/resetpassword
        [HttpPost("/api/v1/account/forgotpassword")]
        public async Task<IActionResult> ForgotPassword([FromBody]string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                return NotFound();
            }
            var result = await _userService.ForgotPasswordAsync(email);
            if (result.IsSuccess)
            {
                return Ok(result);
            }
            return BadRequest(result);
        }

        // /api/v1/account/resetpassword?email&token
        [HttpPost("/api/v1/account/resetpassword")]
        public async Task<IActionResult> ResetPassword([FromForm]ResetPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
               var result = await _userService.ResetPasswordAsync(model);
                if (result.IsSuccess)
                {
                    return Ok(result);
                }
                return BadRequest(result);
            }
            return BadRequest("Some properties are missing");
        }




    }
}
