// 💡 https://jestjs.io/docs/api
import { describe, expect, it, jest } from '@jest/globals';
import { renderHook } from '@testing-library/react-hooks';
import useCleanup from '../source';

describe('useCleanup', () => {
  it('should exist.', () => {
    expect(useCleanup).not.toBeUndefined();
  });

  it('should invoke the callback when unmounted.', () => {
    const cleanupFn = jest.fn();

    const { unmount } = renderHook(() => useCleanup(cleanupFn));

    expect(cleanupFn).not.toHaveBeenCalled();

    unmount();

    expect(cleanupFn).toHaveBeenCalledTimes(1);
  });
});
