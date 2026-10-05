import { useState } from 'react'
//import'./styles'
import './styles/variables.css'
import './styles/globals.css'
import Button from '@/shared/ui/button'
import Input from '@/shared/ui/input'
import  LockerIcon from '@/shared/assets/icons/lockerIcon.svg?react'
function App() {
  return (
    <>
      <h1>Getj started</h1>
      <Button variant="danger">Click me</Button>
      <Input variant="primary" placeholder="Enter text" label="Text Input"/>
    </>
  )
}

export default App
