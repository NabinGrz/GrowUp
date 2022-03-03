using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Exam
    {
        public int Id { get; set; }
        public string StudentId { get; set; }
        public int SkillId { get; set; }
        public Skill Skill { get; set; }
        public int TotalQuestions { get; set; }
        public int ObtainedScore { get; set; }

    }
}
