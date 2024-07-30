using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour
{
    ActionTest inputActions;
    private void Awake()
    {
        inputActions = new ActionTest();
    }

    private void OnEnable()
    {
        inputActions.Enable();

        inputActions.Head.Jump.performed += Jump_performed;
        inputActions.Head.MoveMent.performed += MoveMent_performed;
    }

    private void MoveMent_performed(UnityEngine.InputSystem.InputAction.CallbackContext obj)
    {
        Debug.Log(obj.ReadValue<Vector2>());
    }

    private void Jump_performed(UnityEngine.InputSystem.InputAction.CallbackContext obj)
    {
        Debug.Log("Jump_performed");
        //throw new System.NotImplementedException();
    }

    private void OnDisable()
    {
        inputActions.Head.Jump.performed -= Jump_performed;
        inputActions.Disable();
    }
}
