using Growup.DTOs;
using Growup.Models;
using System.Collections.Generic;

namespace Growup.repository
{
    public interface IMainRepository
    {
        // NewsFeed Methods
        UserResponse SaveNewsFeed(NewsFeed model);
        NewsFeed GetSingleNewsFeed(int id);
        List<NewsFeed> GetNewsFeed();
        List<NewsFeed> GetNewsFeedOfUser(string userId);
        void DeleteNewsFeed(int id);
        UserResponse UpdateNewsFeed(NewsFeed model);

        //comment
        UserResponse SaveComment(Comment comment);
        UserResponse UpdateComment(Comment comment);
        void DeleteComment(int id);
        List<Comment> GetCommentsOfNewsFeed(int id);
        Comment GetSingleComment(int id);
        
        //Skill
        UserResponse SaveSkill(Skill model);
        public UserResponse UpdateSkill(Skill model);

        public List<Skill> GetAllSkill();

        public Skill GetSingleSkill(int id);
        public void DeleteSkill(int id);


        //videos
        UserResponse AddVideo(Videos model);
        UserResponse UpdateVideo(Videos model);
        void DeleteVideo(int id);
        List<Videos> GetVidoesOfSkill(int id);

        UserResponse SaveVideoRating(VideoRating videoRating);
        float GetAverageVideoRating(int videoId);

        UserResponse SaveTeacherRating(TeacherRating teacherRating);
        float GetAverageTeacherRating(string teacherId);
        int CountVideoRating(int videoRatingId);
        int CountTeacherRating(string teacherId);

        //skill Categories
        void AddSkillCategory(SkillCategory model);
        void UpdateSkillCategory(SkillCategory model);
        SkillCategory GetSingleSkillCategory(int id);
        List<SkillCategory> GetAllSkillCategoriesWithSkill();
        void DeleteSkillCategories(int id);
        int VidoesCountInSkill(int id);

        public int CountNewsFeedRating(int newsFeedId);
        public float GetAverageNewsFeedRating(int newsFeedId);
        public UserResponse SaveNewsFeedRating(NewsFeedRating newsFeedRating);
        public void SaveBooking(Booking booking);
        List<Booking> GetStudentsBooking(string studentId);
        List<Booking> GetBookingOfTeachers(string teacherId);

        //Exam
        void SaveQuestion(Question model);
        void UpdateQuestion(Question model);
        void DeleteQuestion(int id);
        List<Question> GetAllQuestionOfSkill(int id);
        void SaveOption(Option option);
        void UpdateOption(Option option);
        void DeleteOption(int id);
        void SaveExamResult(Exam exam);
        List<Exam> GetExamOfStudentInParticularSkill(string studentId, int skillId);
        int GetVideoCountInSkill(int skillId);
    }
}