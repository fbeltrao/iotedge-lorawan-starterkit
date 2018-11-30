using System;
using Xunit;

namespace LoRaWan.NetworkServer.Test
{
    public class RandomTest
    {
        static Random random = new Random();
        [Fact]
        public void It_Works()
        {

        }

        // [Fact]
        // public void It_Works_1_Out_Of_3()
        // {
        //     var val = random.Next(100) + 1;
        //     Assert.True(val <= -1);
        // }

    }

}