using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net;
using System.Net.Sockets;
using System.Linq;
using System;
using System.IO;
using System.Text;
using UnityEngine.Networking;


public class TestServer : MonoBehaviour
{
    // Use this for initialization
    TcpClient client;
    TcpListener listener;
    NetworkStream stream;
    StreamReader reader;

    int socketPort = 8888;
    public int setSize;
    const int SET_SIZE = 101;
    public String[] splitData;
    public String[] xStrings;
    public String[] yStrings;
    public String[] zStrings;

    String message;
    String label;

    public float[] xValues;
    public float[] yValues;
    public float[] zValues;

    private void Awake()
    {
        splitData = new String[SET_SIZE];
        xStrings = new String[SET_SIZE];
        yStrings = new String[SET_SIZE];
        zStrings = new String[SET_SIZE];

        xValues = new float[SET_SIZE];
        yValues = new float[SET_SIZE];
        zValues = new float[SET_SIZE];
    }
    void Start()
    {
        listener = new TcpListener(socketPort);
        listener.Start();
        print("Unity is listening. Port: " + socketPort);
    }

    // Update is called once per frame
    void Update()
    {
        if (!listener.Pending())
        {

        }
        else
        {
            print("Unity is receiving.");
            client = listener.AcceptTcpClient();

            if (client != null)
            {
                Debug.Log("Connected!");
            }

            stream = client.GetStream();
            reader = new StreamReader(stream);
            message = reader.ReadToEnd();
            Debug.Log(message);

            splitData = message.Split('|');

            float p = Convert.ToSingle(splitData[1]);
            setSize = Convert.ToInt32(p);

            if(setSize <= SET_SIZE)
            {
                switch (splitData[0])
                {
                    case "xData":
                        for (int i = 0; i < setSize; i++)
                        {
                            xStrings = message.Split('|');
                            //xStrings[i + 2] = xStrings[i + 2] + "00";
                            xValues[i] = Convert.ToSingle(xStrings[i + 2]);
                        }
                        break;

                    case "yData":
                        for (int i = 0; i < setSize; i++)
                        {
                            zStrings = message.Split('|');
                            //zStrings[i + 2] = zStrings[i + 2] + "00";
                            zValues[i] = Convert.ToSingle(zStrings[i + 2]);
                        }
                        break;

                    case "zData":
                        for (int i = 0; i < setSize; i++)
                        {
                            yStrings = message.Split('|');
                            //yStrings[i + 2] = yStrings[i + 2] + "00";
                            yValues[i] = Convert.ToSingle(yStrings[i + 2]);
                        }
                        break;
                }
            }
            
                
            //data = System.Text.Encoding.ASCII.GetBytes(splitData[5]);
            //Debug.Log(splitData[5]);
            //splitData[5] = splitData[5] + "0000";
            //Debug.Log(splitData[5]);
            //xValues[0] = Convert.ToSingle(splitData[5]);
            //switch (label)
            //{
            //    case 122:
            //        Debug.Log("xValues: " + message);
            //        //data = System.Text.Encoding.UTF32.GetBytes(message);

            //        for (int i = 0; i < cSize; i++)
            //        {
            //            xValues[i] = Convert.ToSingle(data[i + 2]);
            //        }
            //        break;
            //    case 123:
            //        Debug.Log("yValues: " + message);
            //        //data = System.Text.Encoding.UTF32.GetBytes(message);

            //        for (int i = 0; i < cSize; i++)
            //        {
            //            yValues[i] = Convert.ToSingle(data[i + 2]);
            //        }
            //        break;
            //    case 124:
            //        Debug.Log("zValues: " + message);
            //        //data = System.Text.Encoding.UTF32.GetBytes(message);

            //        for (int i = 0; i < cSize; i++)
            //        {
            //            zValues[i] = Convert.ToSingle(data[i + 2]); ;
            //        }
            //        break;



        }

    }
}
