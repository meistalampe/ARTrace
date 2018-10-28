using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour {

	public Transform spawnPos;
	public GameObject spawnee;
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.Space))
        {
			Instantiate(spawnee, spawnPos.position, spawnPos.rotation);
            Debug.Log("Space key was pressed.");
        }
        if (Input.GetKeyUp(KeyCode.Space))
        {
            Debug.Log("Space key was released.");
        }
    }
}
