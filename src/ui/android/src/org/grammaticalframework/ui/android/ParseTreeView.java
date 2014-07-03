package org.grammaticalframework.ui.android;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PointF;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.MotionEvent;
import android.view.View;

import org.grammaticalframework.pgf.Bracket;


public class ParseTreeView extends View {
	private static final float SISTER_SKIP = 25;
	private static final float PARENT_SKIP = 0.5f;
	private static final float ABOVE_LINE_SKIP = 0.1f;
	private static final float BELOW_LINE_SKIP = 0.1f;

	private Paint paint;
	private Object[] brackets;

	private float lastMotionX;
	private float scrollRange;
	
	public ParseTreeView(Context context) {
		this(context, null);
	}

	public ParseTreeView(Context context, AttributeSet attrs) {
		super(context, attrs, R.attr.parseTreeViewStyle);

		paint = new Paint();
		paint.setTextSize(60);
		brackets = null;
		scrollRange = 0;
	}
	
	public Object[] getBrackets() {
		return brackets;
	}

	public void setBrackets(Object[] brackets) {
		this.brackets = brackets;
		awakenScrollBars();
	}

	static class MeasureResult {
		float width = 0.0f;
		float height = 0.0f;
		float nodeTab = 0.0f;
		float nodeCenter = 0.0f;
		float childTab = 0.0f;
		float localWidth = 0.0f;
		float localHeight = 0.0f;
	}

	private MeasureResult mr = new MeasureResult();
	private SparseArray<PointF> coords = new SparseArray<PointF>();

	private void measureTree(Object o, PointF zeroPoint) {
		if (o instanceof Bracket) {
			Bracket bracket = (Bracket) o;

			Rect bounds = new Rect();
			paint.getTextBounds(bracket.cat,0,bracket.cat.length(),bounds);
			float localWidth  = bounds.width();
			float localHeight = bounds.height();
			float layerHeight = localHeight * (1.0f + BELOW_LINE_SKIP + ABOVE_LINE_SKIP + PARENT_SKIP);

			PointF local = coords.get(bracket.fid);
			if (local == null) {
				if (zeroPoint != null)
					coords.put(bracket.fid, zeroPoint);
			} else {
				localWidth = 0; 
			}

			float subWidth = 0.0f;
			float subHeight = 0.0f;
			float nodeCenter = 0.0f;
			for (int i = 0; i < bracket.children.length; i++) {
				measureTree(bracket.children[i], zeroPoint);
				
				if (i == 0) {
					nodeCenter += (subWidth + mr.nodeCenter) / 2.0;
				}
				if (i == bracket.children.length - 1) {
					nodeCenter += (subWidth + mr.nodeCenter) / 2.0;
				}
	
				subWidth += mr.width;
				if (i < bracket.children.length - 1) {
					subWidth += SISTER_SKIP;
				}
	
				if (subHeight < mr.height)
					subHeight = mr.height;
			}
			float localLeft = localWidth / 2.0f;
			float subLeft = nodeCenter;
			float totalLeft = Math.max(localLeft, subLeft);
			float localRight = localWidth / 2.0f;
			float subRight = subWidth - nodeCenter;
			float totalRight = Math.max(localRight, subRight);
			mr.width = totalLeft + totalRight;
			mr.height = layerHeight + subHeight;  
			mr.childTab = totalLeft - subLeft;
			mr.nodeTab = totalLeft - localLeft;
			mr.nodeCenter = nodeCenter + mr.childTab;
			mr.localWidth = localWidth;
			mr.localHeight = localHeight;			
		} else {
			String word = o.toString();

			Rect bounds = new Rect();
			paint.getTextBounds(word,0,word.length(),bounds);
			mr.width  = bounds.width();
			mr.height = bounds.height();
			mr.nodeTab = 0.0f;
			mr.nodeCenter = bounds.width() / 2.0f;
			mr.childTab = 0.0f;
			mr.localWidth = bounds.width();
			mr.localHeight = bounds.height();
		}
	}

	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		if (brackets == null) {
			setMeasuredDimension(0, 0);
			return;
		}

		float width = 0.0f;
		float height = 0.0f;
		PointF zeroPoint = new PointF();
		for (int i = 0; i < brackets.length; i++) {
			measureTree(brackets[i], zeroPoint);

			width += mr.width;
			if (i < brackets.length - 1) {
				width += SISTER_SKIP;
			}

			if (height < mr.height)
				height = mr.height;
		}

		height += paint.getFontMetrics().descent;

		int w = getPaddingLeft() + (int) width  + getPaddingRight();
		int h = getPaddingTop()  + (int) height + getPaddingBottom();

		scrollRange = w+80;

		int widthReq = MeasureSpec.getSize(widthMeasureSpec);
		if (MeasureSpec.getMode(widthMeasureSpec) == MeasureSpec.EXACTLY ||
			(MeasureSpec.getMode(widthMeasureSpec) == MeasureSpec.AT_MOST && w > widthReq)) {
			w = widthReq;
		}
		int heightReq = MeasureSpec.getSize(heightMeasureSpec);
		if (MeasureSpec.getMode(heightMeasureSpec) == MeasureSpec.EXACTLY ||
			(MeasureSpec.getMode(heightMeasureSpec) == MeasureSpec.AT_MOST && h > heightReq)) {
			h = heightReq;
		}

		setMeasuredDimension(w, h);
	}

	private void drawTree(Canvas canvas,
			              float x, float y, float bottom, PointF parentPoint, 
			              Object o) {
		if (o instanceof Bracket) {
			Bracket bracket = (Bracket) o;

			PointF lineStart = coords.get(bracket.fid);
			if (lineStart == null) {
				lineStart = new PointF(x + mr.nodeCenter, y + mr.localHeight * (1.0f + BELOW_LINE_SKIP));
				coords.put(bracket.fid, lineStart);

				if (parentPoint != null) {
					float lineEndX = x + mr.nodeCenter;
					float lineEndY = y;
					canvas.drawLine(parentPoint.x, parentPoint.y, lineEndX, lineEndY, paint);
				}

				canvas.drawText(bracket.cat, x+mr.nodeTab, y+mr.localHeight, paint);
			}

			float layerMultiplier = (1.0f + BELOW_LINE_SKIP + ABOVE_LINE_SKIP + PARENT_SKIP);
			float layerHeight = mr.localHeight * layerMultiplier;
			float childStartX = x + mr.childTab;
			float childStartY = y + layerHeight;
			for (int i = 0; i < bracket.children.length; i++) {
				Object child = bracket.children[i];
				measureTree(child, null);
				float w = mr.width;
				drawTree(canvas, childStartX, childStartY, bottom, lineStart, child);
				childStartX += w + SISTER_SKIP;
			}
		} else  {
			float lineEndX = x + mr.nodeCenter;
			float lineEndY = bottom - mr.height;
			canvas.drawLine(parentPoint.x, parentPoint.y, lineEndX, lineEndY, paint);
			canvas.drawText(o.toString(), x, bottom, paint);
		}
	}

	@Override
	protected void onDraw (Canvas canvas) {
		super.onDraw(canvas);
		
		if (brackets == null) {
			return;
		}

		coords.clear();

		float startX = getPaddingLeft();
		for (int i = 0; i < brackets.length; i++) {
			Object child = brackets[i];

			measureTree(child, null);
			float w = mr.width;
			drawTree(canvas, startX, getPaddingTop(), getPaddingTop()+mr.height, null, child);
			startX += w + SISTER_SKIP;
		}
	}
	
    @Override
    public boolean onTouchEvent(MotionEvent ev) { 
         switch (ev.getAction()) {
             case MotionEvent.ACTION_DOWN: 
                 // Remember where the motion event started
                 lastMotionX = ev.getX();
                 break;
             case MotionEvent.ACTION_MOVE:
                 // Scroll to follow the motion event
            	 float x = ev.getX();
                 final int deltaX = (int) (lastMotionX - x);
                 lastMotionX = x;
                 final int offset = computeHorizontalScrollOffset() + deltaX;
                 final int range = computeHorizontalScrollRange() - computeHorizontalScrollExtent();
                 if (range > 0 && offset > 0 && offset < range)
                	 scrollTo(offset, 0);
                 break;
             case MotionEvent.ACTION_UP:
            	 break;
         }
         return true;
     }
    
     @Override
     protected int computeHorizontalScrollRange() {
    	 return (int) scrollRange;
     }     
}
