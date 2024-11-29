import time
import subprocess

start_time = time.time()

subprocess.run([
    "psql",
    "-U", "postgres",
    "-d", "postgres",
    "-f", "insert_with_transactions.sql"
])

end_time = time.time()
print(f"Execution Time: {end_time - start_time:.2f} seconds")
