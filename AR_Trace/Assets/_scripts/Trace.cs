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

public class Trace : MonoBehaviour {
    // variables initialization
    public Transform markerPrefab;  // needed to place a markerPrefab 
    public Transform marker;    // needed to keep track of current Position where we are placing   
    public Vector3 markerScale;
    public Vector3 markerPosition;
    //[Range(10, 100)]
    public float trace_resolution = 10f;   // estimated length of the trace
    private float step;

    public GameObject scriptObject; TestServer getData;

    // instantiating
    void Awake()
    {
        getData = scriptObject.GetComponent<TestServer>();

        //step = 1f / trace_resolution;
        //markerScale = Vector3.one * step;            // we scale the cubes accordingly so the whole trace covers the segment of 0 to 1
        //markerPosition.x = 0f;
        //markerPosition.y = 0f;
        //markerPosition.z = 0f;
        //for (int i = 0; i < trace_resolution; i++)      // loop places n = trace_length markerPrefabs and creates a straight line by moving each successive Object one bit further to the right
        //{
        //    marker = Instantiate(markerPrefab);     // instantiating places a markerPrefab as an Object in the VR
        //    marker.localScale = markerScale;        // scale adjustment is applied
        //    markerPosition.x = (i + 0.5f) * step;    // position variable is adjusted in x dimension
        //    markerPosition.y = markerPosition.x * markerPosition.x;    // position variable is adjusted in y dimension
            
        //    marker.localPosition = markerPosition;  // object is moved, here shift to the right, also adjusted to the scaling and centering
        //    marker.SetParent(transform, false);     // make objects children of trace and unlink their position from the parent
        //}       
    }


    void Update()
    {
        step = 1f / trace_resolution;
        markerScale = Vector3.one * step;

        for (int i = 0; i < getData.setSize; i++)      // loop places n = trace_length markerPrefabs and creates a straight line by moving each successive Object one bit further to the right
        {
            markerPosition.x = getData.xValues[i];
            markerPosition.y = getData.yValues[i];
            markerPosition.z = getData.zValues[i];
            marker = Instantiate(markerPrefab);     // instantiating places a markerPrefab as an Object in the VR
            marker.localScale = markerScale;        // scale adjustment is applied
            //markerPosition.x = (i + 0.5f) * step;    // position variable is adjusted in x dimension
            //markerPosition.y = markerPosition.x * markerPosition.x;    // position variable is adjusted in y dimension

            marker.position = markerPosition;  // object is moved, here shift to the right, also adjusted to the scaling and centering
            marker.SetParent(transform, false);     // make objects children of trace and unlink their position from the parent
        }
    }
}
