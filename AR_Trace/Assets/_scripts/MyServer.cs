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


public class MyServer : MonoBehaviour {

    // Use this for initialization
    TcpClient client;
    TcpListener listener;
    NetworkStream stream;
    StreamReader reader;
    
    int socketPort = 8888;
    const int READ_BUFFER_SIZE = 1024;
    public byte[] data = new byte[READ_BUFFER_SIZE];
    String strBytesRead;
    String message;
    Int32 label;

    public int cSize;
    public float[] xValues;
    public float[] yValues;
    public float[] zValues;

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
            //Debug.Log(message);

            data = System.Text.Encoding.ASCII.GetBytes(message);

            label = Convert.ToInt32(data[0]);
            cSize = Convert.ToInt32(data[1]);

            xValues = new float[cSize];
            yValues = new float[cSize];
            zValues = new float[cSize];

            switch (label)
            {
                case 122:
                    Debug.Log("xValues: " + message);
                    //data = System.Text.Encoding.UTF32.GetBytes(message);
                    
                    for (int i = 0; i < cSize; i++)
                    {
                        xValues[i] = Convert.ToSingle(data[i + 2]);                       
                    }                      
                    break;
                case 123:
                    Debug.Log("yValues: " + message);
                    //data = System.Text.Encoding.UTF32.GetBytes(message);

                    for (int i = 0; i < cSize; i++)
                    {
                        yValues[i] = Convert.ToSingle(data[i + 2]);
                    }
                    break;
                case 124:
                    Debug.Log("zValues: " + message);
                    //data = System.Text.Encoding.UTF32.GetBytes(message);

                    for (int i = 0; i < cSize; i++)
                    {
                        zValues[i] = Convert.ToSingle(data[i + 2]); ;
                    }
                    break;

            }

            //data = System.Text.Encoding.UTF8.GetBytes(message);
            //Debug.Log(BitConverter.ToString(data)); 

            //cSize = Convert.ToInt32(data[0]);
            
            
            //xValues = new float[cSize];
            //yValues = new float[cSize];
            //zValues = new float[cSize];

            //for(int i=0 ; i<cSize ; i++)
            //{
            //    // switched z and y 
            //    xValues[i] = Convert.ToSingle(data[i + 1]);
            //    zValues[i] = Convert.ToSingle(data[i + cSize + 1]);
            //    yValues[i] = Convert.ToSingle(data[i + 2*cSize + 1]);
            //}

        }

    }
}

    // NOT  WORKING 
    //int connectionID;
    //int maxConnections = 10;
    //int reliableChannelID;
    //int hostID;
    //int socketPort = 8888;
    //byte error;

    //void Start()
    //{
    //    // initialize Server
    //    NetworkTransport.Init();
    //    ConnectionConfig config = new ConnectionConfig();
    //    reliableChannelID = config.AddChannel(QosType.ReliableSequenced);
    //    HostTopology topology = new HostTopology(config, maxConnections);
    //    hostID = NetworkTransport.AddHost(topology, socketPort, null);
    //    Debug.Log("Socket open. Host ID is " + hostID + ", Port: " + socketPort);

    //}

    //void Update()
    //{
    //    // set server up to receive messages
    //    int recHostID;
    //    int recConnectionID;
    //    int recChannelID;
    //    byte[] recBuffer = new byte[1024];
    //    int bufferSize = 1024;
    //    int dataSize;

    //    NetworkEventType recNetworkEvent = NetworkTransport.Receive(out recHostID, out recConnectionID, out recChannelID, recBuffer, bufferSize, out dataSize, out error);

    //    switch(recNetworkEvent)
    //    {
    //        case NetworkEventType.ConnectEvent:
    //            break;
    //        case NetworkEventType.DataEvent:
    //            string msg = Encoding.Unicode.GetString(recBuffer, 0, dataSize);
    //            Debug.Log("Receiving: " + msg);


    //            //string[] splitData = msg.Split('|');

    //            //switch(splitData[0])
    //            //{
    //            //    case "x":
    //            //        for(int i = 0; i< msgSize; i++)
    //            //        {
    //            //            xData[i] = System.Convert.ToSingle(splitData[i + 2]); 
    //            //        }

    //            //        break;
    //            //}
    //            break;
    //        case NetworkEventType.DisconnectEvent:
    //            break;            
    //    }

    //}

