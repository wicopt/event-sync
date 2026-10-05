import styles from './Button.module.css'

export const Button = ({ children, onClick, type = 'button', variant }) => {
  return (
    <button
      className={`${styles.button} ${styles[variant]}`}
      onClick={onClick}
      type={type}

    >
      {children}
    </button>
  )
}
export default Button