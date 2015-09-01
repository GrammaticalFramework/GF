package org.grammaticalframework.ui.android;

import android.view.View;
import android.view.GestureDetector;
import android.view.ScaleGestureDetector;
import android.view.MotionEvent;
import android.graphics.Paint;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Rect;
import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;

public class SemanticGraphView extends View implements GestureDetector.OnGestureListener, ScaleGestureDetector.OnScaleGestureListener, RotationGestureDetector.OnRotationGestureListener {
	
	private SemanticGraph mGraph = new SemanticGraph();
	
	private float mStartX = 0;
	private float mStartY = 0;
	private float mFocusX = 0;
	private float mFocusY = 0;
	private float mScale  = 1;
	private float mAngle  = 0;

	private Paint mPaint;

	private GestureDetector mGD;	
	private ScaleGestureDetector mSGD;
	private RotationGestureDetector mRGD;
	
	private static final float TEXT_PAD = 10;
	private static final float SENSE_POINT_RADIUS = 5;

    public SemanticGraphView(Context context, AttributeSet attrs) {
        super(context, attrs);

		mPaint = new Paint();
		mPaint.setTextSize(60);

		mGD = new GestureDetector(this);
		mSGD = new ScaleGestureDetector(context,this);
		mRGD = new RotationGestureDetector(this);
    }

    public SemanticGraph getGraph() {
		return mGraph;
	}

	public void refresh() {
		mGraph.layout();
		invalidate();
	}

	@Override
	protected void onDraw (Canvas canvas) {
		super.onDraw(canvas);
		
		canvas.scale(mScale,mScale,mFocusX,mFocusY);
		canvas.translate(mStartX, mStartY);
		canvas.rotate(mAngle);

		Rect bounds = new Rect();

		float dx = mGraph.getLayoutMinX();
		float sx = getWidth()/(mGraph.getLayoutMaxX()-mGraph.getLayoutMinX());
		float dy = mGraph.getLayoutMinY();
		float sy = getHeight()/(mGraph.getLayoutMaxY()-mGraph.getLayoutMinY());
		for (SemanticGraph.Node node : mGraph.getNodes()) {
			mPaint.getTextBounds(node.getLemma().toCharArray(), 0, node.getLemma().length(), bounds);
			
			float left   = (node.getLayoutX()-dx)*sx - TEXT_PAD;
			float base   = (node.getLayoutY()-dy)*sy;
			float top    = base - bounds.height() - TEXT_PAD;
			float right  = left + bounds.right + TEXT_PAD;
			float bottom = base + bounds.bottom + TEXT_PAD;
			float sqrt2  = (float) Math.sqrt(2);

			canvas.drawText(node.getLemma(), left + TEXT_PAD, base, mPaint);

			float pi  = (float) Math.PI;
			for (int i = 0; i < node.getSenseCount(); i++) {
				float phi = i * 2*pi / node.getSenseCount();
				float cx = ((left+right) + (right-left)*sqrt2*((float) Math.sin(phi)))/2;
				float cy = ((top+bottom) + (bottom-top)*sqrt2*((float) Math.cos(phi)))/2;

				canvas.drawCircle(cx,cy,SENSE_POINT_RADIUS,mPaint);
			}
		}
	}

	public boolean onTouchEvent(MotionEvent ev) {
		mGD.onTouchEvent(ev);
		mSGD.onTouchEvent(ev);
		mRGD.onTouchEvent(ev);
		return true;
	}
	
	public boolean onDown(MotionEvent e) {
		return true;
	}

	public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
		return true;
	}
	
	public void onLongPress(MotionEvent e) {
	}

	public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
		mStartX -= distanceX;
		mStartY -= distanceY;
		invalidate();
		return true;
	}

	public void onShowPress(MotionEvent e) {
	}

	public boolean onSingleTapUp(MotionEvent e) {
		return true;
	}

	public boolean onScaleBegin(ScaleGestureDetector detector) {
		return true;
	}

	public boolean onScale(ScaleGestureDetector detector) {
		mScale *= detector.getScaleFactor();
		mFocusX = detector.getFocusX();
		mFocusY = detector.getFocusY();
		invalidate();
		return true;
	}

	public void onScaleEnd(ScaleGestureDetector detector) {
	}
	
	public boolean OnRotation(RotationGestureDetector detector) {
		mAngle -= detector.getAngle();
		invalidate();
		return true;
	}
}
