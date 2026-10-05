import styles from "./Input.module.css";
import { useId } from "react";

export const Input = ({
  variant = "primary",
  className,
  label,
  icon,
  id,
  ref,
  error,
  ...props
}) => {
  const autoId = useId();
  const inputId = id ?? autoId;
  const errorId = error ? `${inputId}-error` : undefined;
  return (
    <div className={styles.wrapper}>
      {label && (
        <label className={styles.label} htmlFor={inputId}>
          {label}
        </label>
      )}
      <div
        className={
          styles.inputWrapper +
          " " +
          styles[variant] +
          " " +
          className +
          (error ? " " + styles.invalid : "")
        }
      >
        {icon && <div className={styles.icon}>{icon}</div>}
        <input id={inputId} className={`${styles.input} `} aria-invalid={error ? true : undefined} aria-describedby={errorId}  {...props} />
      </div>
      {error && (
        <span id={errorId} role="alert" className={styles.errorText}>
          {error}
        </span>
      )}
    </div>
  );
};
export default Input;
