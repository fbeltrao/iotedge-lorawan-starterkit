﻿using System;
using System.Collections.Generic;
using System.Text;

namespace LoRaTools.LoRaPhysical
{
    public class Rxpk
    {
        public string time;
        public uint tmms;
        public uint tmst;
        public double freq; //868
        public uint chan;
        public uint rfch;
        public int stat;
        public string modu;
        public string datr;
        public string codr;
        public int rssi;
        public float lsnr;
        public uint size;
        public string data;

        /// <summary>
        /// Required Signal-to-noise ratio to demodulate a LoRa signal given a spread Factor
        /// Spreading Factor -> Required SNR
        /// taken from https://www.semtech.com/uploads/documents/DS_SX1276-7-8-9_W_APP_V5.pdf
        /// </summary>
        private Dictionary<int, double> SpreadFactorToSNR = new Dictionary<int, double>()
         {
            { 6,  -5 },
            { 7, -7.5 },
            {8,  -10 },
            {9, -12.5 },
            {10, -15 },
            {11, -17.5 },
            {12, -20 }
        };

        /// <summary>
        /// Get the modulation margin for MAC Commands LinkCheck
        /// </summary>
        /// <param name="input">the input physical rxpk from the packet</param>
        /// <returns></returns>
        public uint GetModulationMargin()
        {
            //required SNR:
            var requiredSNR = SpreadFactorToSNR[int.Parse(datr.Substring(datr.IndexOf("SF") + 2, datr.IndexOf("BW") - 1 - datr.IndexOf("SF") + 2))];
            //get the minimum
            uint margin = (uint)(lsnr - requiredSNR);
            if (margin < 0)
                margin = 0;
            return margin;
        }
    }

}
