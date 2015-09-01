package org.grammaticalframework.ui.android;

import android.view.MotionEvent;

public class RotationGestureDetector {

	private static final int INVALID_POINTER_ID = -1;
	private float fX, fY, sX, sY, focalX, focalY;
	private int ptrID1, ptrID2;
	private float mAngle;
	private boolean firstTouch;

	private OnRotationGestureListener mListener;

	public RotationGestureDetector(OnRotationGestureListener listener) {
		mListener = listener;
		ptrID1 = INVALID_POINTER_ID;
		ptrID2 = INVALID_POINTER_ID;
	}

	public float getAngle() {
		return mAngle;
	}

	public boolean onTouchEvent(MotionEvent event){
		switch (event.getActionMasked()) {
			case MotionEvent.ACTION_DOWN:
				sX = event.getX();
				sY = event.getY();
				ptrID1 = event.getPointerId(0);
				mAngle = 0;
				firstTouch = true;
				break;
			case MotionEvent.ACTION_POINTER_DOWN:
				fX = event.getX();
				fY = event.getY();
				focalX = getMidpoint(fX, sX);
				focalY = getMidpoint(fY, sY);
				ptrID2 = event.getPointerId(event.getActionIndex());
				mAngle = 0;
				firstTouch = true;
				break;
			case MotionEvent.ACTION_MOVE:
				if(ptrID1 != INVALID_POINTER_ID && ptrID2 != INVALID_POINTER_ID) {
					float nfX, nfY, nsX, nsY;
					nsX = event.getX(event.findPointerIndex(ptrID1));
					nsY = event.getY(event.findPointerIndex(ptrID1));
					nfX = event.getX(event.findPointerIndex(ptrID2));
					nfY = event.getY(event.findPointerIndex(ptrID2));
					if (firstTouch) {
						mAngle = 0;
						firstTouch = false;
					} else {
						mAngle = angleBetweenLines(fX, fY, sX, sY, nfX, nfY, nsX, nsY);
					}

					if (mListener != null) {
						mListener.OnRotation(this);
					}
					fX = nfX;
					fY = nfY;
					sX = nsX;
					sY = nsY;
				}
				break;
			case MotionEvent.ACTION_UP:
				ptrID1 = INVALID_POINTER_ID;
				break;
			case MotionEvent.ACTION_POINTER_UP:
				ptrID2 = INVALID_POINTER_ID;
				break;
		}
		return true;
	}

	private float getMidpoint(float a, float b) {
		return (a + b) / 2;
	}

	private float findAngleDelta(float angle1, float angle2)
	{
		angle2 = angle2 % 360.0f;
		angle1 = angle1 % 360.0f;

		float dist = angle1 - angle2;
		if (dist < -180.0f)
		{
			dist += 360.0f;
		}
		else if (dist > 180.0f)
		{
			dist -= 360.0f;
		}

		return dist;
	}

	private float angleBetweenLines(float fx1, float fy1, float fx2, float fy2, float sx1, float sy1, float sx2, float sy2)
	{
		float angle1 = (float) Math.atan2((fy1 - fy2), (fx1 - fx2));
		float angle2 = (float) Math.atan2((sy1 - sy2), (sx1 - sx2));

		return findAngleDelta((float)Math.toDegrees(angle1),(float)Math.toDegrees(angle2));
	}

	public static interface OnRotationGestureListener {
		public boolean OnRotation(RotationGestureDetector detector);
	}
}
