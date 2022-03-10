import { useEffect } from 'react';

function useCleanup(destructor: VoidFunction): void {
  useEffect(() => {
    return destructor;
  }, []);
}

export default useCleanup;
