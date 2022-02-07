using Growup.Data;
using Growup.DTOs;
using Growup.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.repository
{
    public class MainRepository : IMainRepository
    {
        public GrowupDbContext _db;
        public MainRepository(GrowupDbContext db)
        {
            _db = db;
        }

        // saves the news feed with image
        public UserResponse SaveNewsFeed(NewsFeed model)
        {
            try
            {
                _db.NewsFeeds.Add(model);
                _db.SaveChanges();
                return new UserResponse
                {
                    Message = "NewsFeed saved successfully!",
                    IsSuccess = true
                };
            }
            catch (Exception e)
            {
                return new UserResponse
                {
                    Message = "Error occured while saving newsfeed",
                    IsSuccess = false
                };
            }

        }

        //returns single news feed
        public NewsFeed GetSingleNewsFeed(int id)
        {
            return _db.NewsFeeds.Include("ApplicationUser").SingleOrDefault(m => m.Id == id);
        }

        //return list of news feed
        public List<NewsFeed> GetNewsFeed()
        {
            return _db.NewsFeeds.ToList();
        }

        //return list of news feed of a particular users
        public List<NewsFeed> GetNewsFeedOfUser(string userId)
        {
            return _db.NewsFeeds.Where(m => m.ApplicationUserId == userId).ToList();
        }

        //delete news feed
        public void DeleteNewsFeed(int id)
        {
            var newsFeedInDb = _db.NewsFeeds.SingleOrDefault(m => m.Id == id);
             _db.NewsFeeds.Remove(newsFeedInDb);
        }


        //update news feed
        public UserResponse UpdateNewsFeed(NewsFeed model)
        {
            try
            {
                var newsFeedInDb = _db.NewsFeeds.SingleOrDefault(m => m.Id == model.Id);
                newsFeedInDb.Title = model.Title;
                newsFeedInDb.ImageUrl = model.ImageUrl;
                _db.SaveChanges();
                return new UserResponse
                {
                    Message = "NewsFeed Updated successfully!",
                    IsSuccess = true
                };
            }
            catch (Exception)
            {

                return new UserResponse
                {
                    Message = "NewsFeed not saved successfully!",
                    IsSuccess = true
                };
            }
            
        }


        public UserResponse SaveComment(Comment comment)
        {
            try
            {
                _db.Comments.Add(comment);
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Comment add successfull!"
                };
            }
            catch (Exception)
            {

                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Something went wrong"
                };
            }
            
        }

        public UserResponse UpdateComment(Comment comment)
        {
            try
            {
                var commentInDb = _db.Comments.SingleOrDefault(m => m.Id == comment.Id);
                commentInDb.Description = comment.Description;
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Comment Added Successfully!"
                };
            }
            catch (Exception)
            {

                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Something went wrong"
                };
            }

        }

        public void DeleteComment(int id)
        {
            var commentInDb = _db.Comments.SingleOrDefault(m => m.Id == id);
            _db.Comments.Remove(commentInDb);
            _db.SaveChanges();
        }

        public List<Comment> GetCommentsOfNewsFeed(int id)
        {
            return _db.Comments.Where(m => m.NewsFeedId == id).ToList();
        }

        public Comment GetSingleComment(int id)
        {
            return _db.Comments.SingleOrDefault(m => m.Id == id);
        }

        public UserResponse SaveSkill(Skill model)
        {
            try
            {
                _db.Skills.Add(model);
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Skill created succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }


        public UserResponse UpdateSkill(Skill model)
        {
            try
            {
                var skillInDb = _db.Skills.SingleOrDefault(m => m.Id == model.Id);
                skillInDb.Title = model.Title;
                skillInDb.TitleImage = model.TitleImage;
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Skill update succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }

        public List<Skill> GetAllSkill()
        {
            return _db.Skills.ToList();
        }

        public Skill GetSingleSkill(int id)
        {
            return _db.Skills.Include("Videos").SingleOrDefault(m => m.Id == id);
        }

        public void DeleteSkill(int id)
        {
            var skillInDb = _db.Skills.SingleOrDefault(m => m.Id == id);
            _db.Skills.Remove(skillInDb);
            _db.SaveChanges();
        }

        public UserResponse AddVideo(Videos model)
        {
            try
            {
                _db.Videos.Add(model);
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Video added succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }

        public UserResponse UpdateVideo(Videos model)
        {
            try
            {
                var videoInDb = _db.Videos.SingleOrDefault(m => m.Id == model.Id);
                videoInDb.Rating = model.Rating;
                videoInDb.VideoUrl = model.VideoUrl;
                _db.SaveChanges();
                return new UserResponse()
                {
                    IsSuccess = true,
                    Message = "Video Updated succesfully!"
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    IsSuccess = false,
                    Message = "Internal Server Error"
                };
            }
        }

        public void DeleteVideo(int id)
        {
            var video = _db.Videos.SingleOrDefault(m => m.Id == id);
            _db.Videos.Remove(video);
            _db.SaveChanges();

        }

        public List<Videos> GetVidoesOfSkill(int id)
        {
            return _db.Videos.Where(m => m.SkillId == id).ToList();
        }
        
        public UserResponse SaveVideoRating(VideoRating videoRating)
        {
            try
            {
                var videoRatingInDb = _db.VideoRatings
                    .SingleOrDefault(m => m.ApplicationUserId == videoRating.ApplicationUserId && m.VideoId == videoRating.VideoId);
                if(videoRatingInDb == null)
                {
                    _db.VideoRatings.Add(videoRating);
                    _db.SaveChanges();
                }
                else
                {
                    videoRatingInDb.Rating = videoRating.Rating;
                    _db.SaveChanges();
                }
                return new UserResponse()
                {
                    Message = "User Saved Successfully",
                    IsSuccess = true
                };
            }
            catch (Exception)
            {
                return new UserResponse()
                {
                    Message = "Something went wrong",
                    IsSuccess = false
                };
            }
        }
        

        public float GetAverageVideoRating(int videoId)
        {
            var ratingOfVideo = _db.VideoRatings.Where(m => m.VideoId == videoId);
            var average = ratingOfVideo.Average(m => m.Rating);
            return average;
        }

    }
}
