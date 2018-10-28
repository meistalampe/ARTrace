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

public class DrawLine : MonoBehaviour {
    public GameObject scriptObject; MyServer getData;

    private LineRenderer lineRenderer;
    private float counter;
    //private float dist;
    
    //public float lineDrawSpeed = 6f;

    // Use this for initialization
    void Start ()
    {
           
        lineRenderer = GetComponent<LineRenderer>();
        lineRenderer.SetPosition(0, new Vector3(0.0f, 0.0f, 0.0f));
        lineRenderer.SetPosition(1, new Vector3(0.0f, 0.0f, 0.0f));
        //lineRenderer.SetWidth(.45f, .45f);
        //dist = Vector3.Distance(origin.position, destination.position);        
    }
	
	// Update is called once per frame
	void Update ()
    {
        getData = scriptObject.GetComponent<MyServer>();
        lineRenderer.positionCount = getData.cSize;

        for (int i=0 ; i < lineRenderer.positionCount ; i++)
        {
            lineRenderer.SetPosition(i, new Vector3(getData.xValues[i], getData.yValues[i], getData.zValues[i]));
        }
        // line draw animation for later Subroutine ..see floor in VrRoom
		//if(counter < dist)
  //      {
  //          counter += .1f / lineDrawSpeed;

  //          float x = Mathf.Lerp(0, dist, counter);

  //          Vector3 pointA = origin.position;
  //          Vector3 pointB = destination.position;

  //          Vector3 pointAlongLine = x * Vector3.Normalize(pointB - pointA) + pointA;

  //          lineRenderer.SetPosition(1, pointAlongLine);
  //      }
	}
}
